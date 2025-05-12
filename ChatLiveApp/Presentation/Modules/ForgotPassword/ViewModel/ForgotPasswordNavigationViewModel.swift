
import UIKit

class ForgotPasswordNavigationViewModel {
    private let navigator: ForgotPasswordNavigating
    
    init(navigator: ForgotPasswordNavigating) {
        self.navigator = navigator
    }
    
    func didTapBackToSignIn(from viewController: UIViewController) {
        navigator.navigateToLogin(from: viewController)
    }
}

