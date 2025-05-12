
import UIKit

class RegisterNavigationHandler: RegisterNavigating {
    func navigateBackToLogin(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func navigateToChats(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Chats", bundle: nil)
        guard let chatsVC = storyboard.instantiateViewController(withIdentifier: "ChatsViewController") as? ChatsViewController else {
            return
        }
        viewController.navigationController?.pushViewController(chatsVC, animated: true)
    }
}
