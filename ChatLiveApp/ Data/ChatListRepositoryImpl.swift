
import FirebaseFirestore

class ChatListRepositoryImpl: ChatListRepository {
    
    private var listener: ListenerRegistration?
    
    func fetchChatList(for userId: String, completion: @escaping ([ChatOverview]) -> Void) {
        let db = Firestore.firestore()
        
        listener?.remove()
        
        listener = db.collection("chats")
            .whereField("participants", arrayContains: userId)
            .order(by: "lastMessageDate", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching chats: \(error)")
                    completion([])
                    return
                }
                
                var chats: [ChatOverview] = []
                let group = DispatchGroup()
                
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    
                    guard let participants = data["participants"] as? [String],
                          let lastMessage = data["lastMessage"] as? String,
                          let timestamp = data["lastMessageDate"] as? Timestamp,
                          let unreadMessagesCountDict = data["unreadMessagesCount"] as? [String: Int] else {
                        return
                    }
                    
                    let unreadMessagesCount = unreadMessagesCountDict[userId] ?? 0
                    let otherUserId = participants.first(where: { $0 != userId }) ?? ""
                    
                    group.enter()
                    db.collection("users").document(otherUserId).getDocument { userSnapshot, error in
                        var otherUserName = "Unknown"
                        var otherUserImageURL: String? = nil
                        if let userData = userSnapshot?.data() {
                            otherUserName = userData["name"] as? String ?? otherUserName
                            otherUserImageURL = userData["userImageURL"] as? String
                        }
                        let chat = ChatOverview(
                            chatId: document.documentID,
                            userName: otherUserName,
                            userImageURL: otherUserImageURL,
                            lastMessage: lastMessage,
                            lastMessageDate: timestamp.dateValue(),
                            unreadMessagesCount: unreadMessagesCount
                        )
                        
                        chats.append(chat)
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(chats.sorted(by: { $0.lastMessageDate > $1.lastMessageDate }))
                }
            }
    }
    
    func removeListener() {
        listener?.remove()
        listener = nil
    }
}
