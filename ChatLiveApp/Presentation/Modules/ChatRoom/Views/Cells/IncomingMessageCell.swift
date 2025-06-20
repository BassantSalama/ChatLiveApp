
import UIKit

class IncomingMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var incomingBubbleView: UIView!
    @IBOutlet weak var incomingMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with message: String) {
        incomingMessageLabel.text = message
    }
    
}
