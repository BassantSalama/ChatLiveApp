

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLbl: UILabel!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var HaveAccontLbl: UILabel!
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setUpHaveAccountTapped()
    }
    
    func setupBindings() {
        viewModel.onRegisterSuccess = { [weak self] in
            DispatchQueue.main.async {
                print("Registration Successful")
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
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        viewModel.register(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTxtField.text ?? ""
        )
    }
    
    private func setUpHaveAccountTapped(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHaveAccount))
        HaveAccontLbl.isUserInteractionEnabled = true
        HaveAccontLbl.addGestureRecognizer(tap)
    }
    
    @objc private func didTapHaveAccount(){
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
