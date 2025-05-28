
protocol ChatListRepository {
    func fetchChatList(for userId: String, completion: @escaping ([ChatOverview]) -> Void)
    func removeListener()
}
