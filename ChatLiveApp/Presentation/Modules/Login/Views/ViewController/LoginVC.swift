

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPasswordLbl: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var newUserLbl: UILabel!
    
    private let viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setupBindings()
           setupCreateAccountTap()
       }

       @IBAction func signInButtonTapped(_ sender: UIButton) {
           let email = emailTextField.text ?? ""
           let password = passwordTextField.text ?? ""
           viewModel.login(email: email, password: password)
       }

       private func setupBindings() {
           viewModel.onLoginSuccess = { [weak self] in
               DispatchQueue.main.async {
                   self?.performSegue(withIdentifier: "goToChatsSecreen", sender: nil)
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

       private func setupCreateAccountTap() {
           let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCreateAccount))
           newUserLbl.isUserInteractionEnabled = true
           newUserLbl.addGestureRecognizer(tap)
       }

       @objc private func didTapCreateAccount() {
           performSegue(withIdentifier: "goToRegister", sender: nil)
           print("👤 Navigate to Register screen")
       }
   }
