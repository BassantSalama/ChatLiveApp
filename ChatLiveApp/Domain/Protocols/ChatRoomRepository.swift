
protocol ChatRoomRepository {
    func createChat(with participants: [String], completion: @escaping (Result<String, Error>) -> Void)
    func sendMessage(_ message: Message, chatId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func observeMessages(chatId: String, onUpdate: @escaping ([Message]) -> Void)
    func resetUnreadCount(for userId: String, chatId: String, completion: @escaping (Result<Void, Error>) -> Void)
}
