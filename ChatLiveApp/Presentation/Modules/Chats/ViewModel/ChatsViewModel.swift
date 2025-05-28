
class ChatsViewModel {
    
    private let fetchChatListUseCase: FetchChatListUseCase
    private var currentUserId: String?
    var chats: [ChatOverview] = []
    
    var onChatsUpdated: (() -> Void)?
    
    init(fetchChatListUseCase: FetchChatListUseCase) {
        self.fetchChatListUseCase = fetchChatListUseCase
    }
    
    func loadChats(for userId: String) {
        currentUserId = userId
        fetchChatListUseCase.execute(for: userId) { [weak self] chats in
            self?.chats = chats
            self?.onChatsUpdated?()
        }
    }

    func stopListening() {
        fetchChatListUseCase.stopListening()
    }

}
