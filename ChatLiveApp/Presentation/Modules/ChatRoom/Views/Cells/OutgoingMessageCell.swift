
import UIKit

class OutgoingMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var outgoinMessageView: UIView!
    @IBOutlet weak var outgoingMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with message: String) {
        outgoingMessage.text = message
    }
}
