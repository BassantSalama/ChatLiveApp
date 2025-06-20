

import FirebaseAuth

class ForgotPasswordViewModel {
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    func sendResetLink(email: String) {
        guard !email.isEmpty, email.contains("@") else {
            onFailure?("Please enter a valid email address.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.onFailure?(error.localizedDescription)
            } else {
                self?.onSuccess?()
            }
        }
    }
}
