
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerScrollView: UIScrollView!
    @IBOutlet weak var registerContentView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    private let viewModel = RegisterViewModel(navigator: RegisterNavigationHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHaveAccountTap()
    }
    
    private func setupHaveAccountTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHaveAccount))
        haveAccountLabel.isUserInteractionEnabled = true
        haveAccountLabel.addGestureRecognizer(tap)
    }

    @objc private func didTapHaveAccount() {
        viewModel.didTapHaveAccount(from: self)
    }
    
}
