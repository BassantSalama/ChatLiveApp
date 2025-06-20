
import FirebaseFirestore

class ChatRoomRepositoryImpl: ChatRoomRepository {
    
    private let db = Firestore.firestore()
    
    func createChat(with participants: [String], completion: @escaping (Result<String, Error>) -> Void) {
        let docReference = db.collection("chats").document()
        let chatData: [String: Any] = [
            "participants": participants,
            "lastMessage": "",
            "lastMessageDate": Timestamp(date: Date()),
            "unreadMessagesCount": 0
        ]
        docReference.setData(chatData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(docReference.documentID))
            }
        }
    }
    func sendMessage(_ message: Message, chatId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let messageData: [String: Any] = [
            "content": message.content,
            "senderId": message.senderId,
            "timestamp": Timestamp(date: message.timestamp)
        ]
        let chatRef = db.collection("chats").document(chatId)
        chatRef.collection("messages").addDocument(data: messageData) { [weak self] error in
            if let error = error {
                completion(.failure(error))
                return
            }
            chatRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(),
                      var unreadCounts = data["unreadMessagesCount"] as? [String: Int],
                      let participants = data["participants"] as? [String],
                      error == nil else {
                    completion(.success(()))
                    return
                }
                for participantId in participants {
                    if participantId != message.senderId {
                        let currentCount = unreadCounts[participantId] ?? 0
                        unreadCounts[participantId] = currentCount + 1
                    }
                }
                chatRef.updateData([
                    "lastMessage": message.content,
                    "lastMessageDate": Timestamp(date: message.timestamp),
                    "unreadMessagesCount": unreadCounts
                ]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    func observeMessages(chatId: String, onUpdate: @escaping ([Message]) -> Void) {
        db.collection("chats").document(chatId).collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error observing messages: \(error)")
                    onUpdate([])
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    onUpdate([])
                    return
                }
                print("Messages count: \(documents.count)")
                let messages = documents.compactMap { doc -> Message? in
                    let data = doc.data()
                    guard let content = data["content"] as? String,
                          let senderId = data["senderId"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp else { return nil }
                    return Message(id: doc.documentID, content: content, senderId: senderId, timestamp: timestamp.dateValue())
                }
                onUpdate(messages)
            }
    }
    func resetUnreadCount(for userId: String, chatId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let chatRef = db.collection("chats").document(chatId)
        chatRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  var unreadCounts = data["unreadMessagesCount"] as? [String: Int] else {
                completion(.success(()))
                return
            }
            unreadCounts[userId] = 0
            chatRef.updateData(["unreadMessagesCount": unreadCounts]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
}


