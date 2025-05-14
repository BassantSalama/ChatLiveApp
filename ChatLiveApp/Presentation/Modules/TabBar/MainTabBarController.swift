
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }
}
private extension MainTabBarController {
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
private extension MainTabBarController {
    func setupViewControllers() {
        let chatsVC = createChatsTab()
        let settingsVC = createSettingsTab()
        self.viewControllers = [chatsVC, settingsVC]
    }
    
    func createChatsTab() -> UIViewController {
        let storyboard = UIStoryboard(name: "Chats", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "ChatsNavController")
        navController.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), tag: 0)
        return navController
    }
    
    func createSettingsTab() -> UIViewController {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "SettingsNavController")
        navController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        return navController
    }
}
