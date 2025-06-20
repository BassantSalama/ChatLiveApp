
import FirebaseAuth
import FirebaseFirestore

class ChatRoomViewModel {
    
    private let chatRoomRepository: ChatRoomRepository
    private(set) var chatId: String?
    private(set) var currentUserId: String
    
    var messages: [Message] = []
    var onMessagesUpdated: (() -> Void)?
    var onChatCreated: ((String) -> Void)?
    
    init(chatRoomRepository: ChatRoomRepository, chatId: String, currentUserId: String) {
        self.chatRoomRepository = chatRoomRepository
        self.chatId = chatId
        self.currentUserId = currentUserId
    }
    
    func createChat(with participants: [String]) {
        chatRoomRepository.createChat(with: participants) { [weak self] result in
            switch result {
            case .success(let chatId):
                self?.chatId = chatId
                self?.onChatCreated?(chatId)
                self?.observeMessages(chatId: chatId)
            case .failure(let error):
                print("❌ Failed to create chat: \(error.localizedDescription)")
            }
        }
    }
    
    func observeMessages(chatId: String) {
        chatRoomRepository.resetUnreadCount(for: currentUserId, chatId: chatId) { result in
            switch result {
            case .success():
                print("Unread count reset successfully")
            case .failure(let error):
                print("Failed to reset unread count: \(error.localizedDescription)")
            }
        }
        
        chatRoomRepository.observeMessages(chatId: chatId) { [weak self] messages in
            self?.messages = messages
            self?.onMessagesUpdated?()
        }
    }
    
    func sendMessage(content: String) {
        guard let chatId = chatId else { return }
        
        guard let currentUser = Auth.auth().currentUser else {
            print("❌ No authenticated user")
            return
        }
        let message = Message(
            id: UUID().uuidString,
            content: content,
            senderId: currentUserId,
            timestamp: Date()
        )
        
        chatRoomRepository.sendMessage(message, chatId: chatId) { result in
            switch result {
            case .success:
                print("✅ Message sent")
            case .failure(let error):
                print("❌ Failed to send: \(error.localizedDescription)")
            }
        }
    }
    
    func isMessageOutgoing(_ message: Message) -> Bool {
        return message.senderId == currentUserId
    }
    
    func markMessagesAsRead() {
        chatRoomRepository.resetUnreadCount(for: currentUserId, chatId: chatId!) { result in
            switch result {
            case .success():
                print("Unread count reset successfully")
            case .failure(let error):
                print("Failed to reset unread count: \(error)")
            }
        }
    }
}
