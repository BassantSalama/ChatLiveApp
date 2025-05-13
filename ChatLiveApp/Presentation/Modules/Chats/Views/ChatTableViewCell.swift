
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
        unReadCounterView.layer.cornerRadius = unReadCounterView.frame.width/2
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
