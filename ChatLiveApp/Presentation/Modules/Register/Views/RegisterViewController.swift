
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
    
    private let navigationViewModel = RegisterNavigationViewModel(navigator: RegisterNavigationHandler())
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupHaveAccountTap()
        observeKeyboard(for: registerScrollView)
    }
    
    func setupBindings() {
        viewModel.onRegisterSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationViewModel.didFinishRegister(from: self!)
            }
        }
        
        viewModel.onRegisterFailure = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Register Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let confirmPassword = confirmPasswordTextField.text ?? ""
            viewModel.register(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    private func setupHaveAccountTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHaveAccount))
        haveAccountLabel.isUserInteractionEnabled = true
        haveAccountLabel.addGestureRecognizer(tap)
    }
    
    @objc private func didTapHaveAccount() {
        navigationViewModel.didTapHaveAccount(from: self)
    }
    
}
