
import UIKit

class ForgotPasswordViewModel {
    private let navigator: ForgotPasswordNavigating
    
    init(navigator: ForgotPasswordNavigating) {
        self.navigator = navigator
    }
    
    func didTapSignIn(from viewController: UIViewController) {
        navigator.navigateToLogin(from: viewController)
    }
}

