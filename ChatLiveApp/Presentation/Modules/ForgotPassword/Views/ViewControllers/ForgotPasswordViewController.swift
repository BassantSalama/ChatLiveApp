
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordScrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordContetView: UIView!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var enterEmailLabel: UILabel!
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backToSignInLabel: UILabel!
    
    private let navigationViewModel = ForgotPasswordNavigationViewModel(navigator: ForgotPasswordNavigationHandler())
    private let viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupSignInTap()
        observeKeyboard(for: forgotPasswordScrollView)
    }
    
    func setupBindings() {
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Check Your Email",
                    message: "We've sent a password reset link to your email.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
        
        viewModel.onFailure = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Error",
                    message: error,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func didTapSendButto(_ sender: Any) {
        let email = enterEmailTextField.text ?? ""
        viewModel.sendResetLink(email: email)
    }
    
    
    private func setupSignInTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackToSignIn))
        backToSignInLabel.isUserInteractionEnabled = true
        backToSignInLabel.addGestureRecognizer(tap)
    }
    
    @objc private func didTapBackToSignIn() {
        navigationViewModel.didTapBackToSignIn(from: self)
    }
}
