
class FetchChatListUseCase {
    private let repository: ChatListRepository
    
    init(repository: ChatListRepository) {
        self.repository = repository
    }
    
    func execute(for userId: String, completion: @escaping ([ChatOverview]) -> Void) {
        repository.fetchChatList(for: userId, completion: completion)
    }
    
    func stopListening() {
            repository.removeListener()
        }
}
