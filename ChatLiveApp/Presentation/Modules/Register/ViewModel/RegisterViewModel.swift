import UIKit

class RegisterViewModel {
    private let navigator: RegisterNavigating

    init(navigator: RegisterNavigating) {
        self.navigator = navigator
    }

    func didTapHaveAccount(from viewController: UIViewController) {
        navigator.navigateBackToLogin(from: viewController)
    }
}

