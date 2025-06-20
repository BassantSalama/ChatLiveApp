
import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMassageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var unReadCounterLabel: UILabel!
    @IBOutlet weak var unReadCounterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        unReadCounterView.layer.cornerRadius = unReadCounterView.frame.width / 2
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    func configure(with chat: ChatOverview) {
        
        if let imageName = chat.userImageURL {
            profileImageView.image = UIImage(named: imageName)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle.fill")
        }
        userNameLabel.text = chat.userName
        lastMassageLabel.text = chat.lastMessage
        timeLabel.text = format(chat.lastMessageDate)
        unReadCounterLabel.isHidden = chat.unreadMessagesCount == 0
        unReadCounterView.isHidden = chat.unreadMessagesCount == 0
        unReadCounterLabel.text = "\(chat.unreadMessagesCount)"
    }
    
    private func format(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
