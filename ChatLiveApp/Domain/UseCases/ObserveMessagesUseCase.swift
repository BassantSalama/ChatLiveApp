
class ObserveMessagesUseCase {
    private let repository: ChatRoomRepository
    
    init(repository: ChatRoomRepository) {
        self.repository = repository
    }
    
    func execute(chatId: String, onUpdate: @escaping ([Message]) -> Void) {
        repository.observeMessages(chatId: chatId, onUpdate: onUpdate)
    }
}
