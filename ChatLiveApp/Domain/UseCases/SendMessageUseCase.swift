
class SendMessageUseCase {
    private let repository: ChatRoomRepository
    
    init(repository: ChatRoomRepository) {
        self.repository = repository
    }

    func execute(message: Message, chatId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.sendMessage(message, chatId: chatId, completion: completion)
    }
}
