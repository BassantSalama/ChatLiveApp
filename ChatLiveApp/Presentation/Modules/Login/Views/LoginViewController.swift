
import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var forgetPasswordLabel: UILabel!

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var newUserLabel: UILabel!
    
    private let navigationViewModel: LoginNavigationViewModel = LoginNavigationViewModel(navigator: LoginNavigationHandler())
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupCreateAccountTap()
        setupForgotPasswordTap()
        observeKeyboard(for: loginScrollView)
    }
    
    
    private func setupBindings() {
        viewModel.onLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.navigationViewModel.didTapSignInButton(from: self)
            }
        }
        
        viewModel.onLoginFailure = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Login Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
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
        navigationViewModel.didTapCreateAccount(from: self)
    }
    
    @objc private func didTapForgotPassword() {
        navigationViewModel.didTapForgotPassword(from: self)
    }
    

}
