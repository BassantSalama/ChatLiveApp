
import UIKit

class LoginNavigationHandler: LoginNavigating {
    
    func navigateToMainTabBar(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? MainTabBarController
        else {
            return
        }
        tabBarController.modalPresentationStyle = .fullScreen
        viewController.present(tabBarController, animated: true, completion: nil)
    }
    
    func navigateToRegister(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        guard let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
            return
        }
        viewController.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func navigateToForgotPassword(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        guard let forgotVC = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController else {
            return
        }
        viewController.navigationController?.pushViewController(forgotVC, animated: true)
    }
}
