import UIKit

class LoginViewModel {
    private let navigator: LoginNavigating
    
    init(navigator: LoginNavigating) {
        self.navigator = navigator
    }
    
    func didTapCreateAccount(from viewController: UIViewController) {
        navigator.navigateToRegister(from: viewController)
    }

    func didTapForgotPassword(from viewController: UIViewController) {
        navigator.navigateToForgotPassword(from: viewController)
    }
}
