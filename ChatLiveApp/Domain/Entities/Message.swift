import Foundation

struct Message {
    var id: String = UUID().uuidString
    let content: String
    let senderId: String
    let timestamp: Date
    
    init(id: String = UUID().uuidString, content: String, senderId: String, timestamp: Date) {
        self.id = id
        self.content = content
        self.senderId = senderId
        self.timestamp = timestamp
    }
    
    func isIncoming(currentUserId: String) -> Bool {
        return senderId != currentUserId
    }
}
