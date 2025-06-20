import Foundation

struct ChatOverview {
    let chatId: String
    let userName: String
    let userImageURL: String?
    let lastMessage: String
    let lastMessageDate: Date
    let unreadMessagesCount: Int
}

