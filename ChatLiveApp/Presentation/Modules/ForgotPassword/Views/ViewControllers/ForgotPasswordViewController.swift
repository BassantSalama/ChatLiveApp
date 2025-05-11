
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordScrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordContetView: UIView!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var enterEmailLabel: UILabel!
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backToSignInLabel: UILabel!
    
    private let viewModel = ForgotPasswordViewModel(navigator: ForgotPasswordNavigationHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInTap()
    }
    
    private func setupSignInTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSignIn))
        backToSignInLabel.isUserInteractionEnabled = true
        backToSignInLabel.addGestureRecognizer(tap)
    }
    
    @objc private func didTapSignIn() {
        viewModel.didTapSignIn(from: self)
    }
}
