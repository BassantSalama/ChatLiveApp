
import UIKit

class RegisterNavigationHandler: RegisterNavigating {
    func navigateBackToLogin(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
