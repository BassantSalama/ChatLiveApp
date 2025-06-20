import UIKit

class RegisterNavigationViewModel {
    private let navigator: RegisterNavigating

    init(navigator: RegisterNavigating) {
        self.navigator = navigator
    }

    func didTapHaveAccount(from viewController: UIViewController) {
        navigator.navigateBackToLogin(from: viewController)
    }
    
    func didFinishRegister(from viewController: UIViewController){
        navigator.navigateToChats(from: viewController)
    }
}

