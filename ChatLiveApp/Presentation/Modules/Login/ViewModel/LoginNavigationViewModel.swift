import UIKit

class LoginNavigationViewModel {
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
    
    func didTapSignInButton(from viewController: UIViewController){
        print("🔁 Navigating to MainTabBar...")
        navigator.navigateToMainTabBar(from: viewController)
        
    }
}
