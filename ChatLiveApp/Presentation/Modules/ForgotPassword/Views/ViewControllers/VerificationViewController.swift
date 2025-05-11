
import UIKit

class VerificationViewController: UIViewController {
    
    @IBOutlet weak var verificationScrollView: UIScrollView!
    @IBOutlet weak var verificationContentView: UIView!
    @IBOutlet weak var verificationLabel: UILabel!
    @IBOutlet weak var enterVerificationLabel: UILabel!
    @IBOutlet weak var verificationTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var didnotReciveCodeLabel: UILabel!
    @IBOutlet weak var resendLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
