
import UIKit

class ForgotPasswordNavigationHandler: ForgotPasswordNavigating {
    func navigateToLogin(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        viewController.navigationController?.pushViewController(loginVC, animated: true)
    }
}
