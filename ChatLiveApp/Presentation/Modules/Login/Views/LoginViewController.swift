
import UIKit

class LoginViewController: UIViewController {
    


    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var forgetPasswordLabel: UILabel!

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var newUserLabel: UILabel!
    
    private let viewModel: LoginViewModel = LoginViewModel(navigator: LoginNavigationHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCreateAccountTap()
        setupForgotPasswordTap()
        
    }
    
    private func setupCreateAccountTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCreateAccount))
        newUserLabel.isUserInteractionEnabled = true
        newUserLabel.addGestureRecognizer(tap)
    }
    
    private func setupForgotPasswordTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapForgotPassword))
        forgetPasswordLabel.isUserInteractionEnabled = true
        forgetPasswordLabel.addGestureRecognizer(tap)
    }
    
    @objc private func didTapCreateAccount() {
        viewModel.didTapCreateAccount(from: self)
    }
    
    @objc private func didTapForgotPassword() {
        viewModel.didTapForgotPassword(from: self)
    }
    

}
