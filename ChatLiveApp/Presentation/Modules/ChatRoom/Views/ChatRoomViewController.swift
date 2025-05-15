
import UIKit

class ChatRoomViewController: UIViewController {

    @IBOutlet weak var chatRoomCollectionView: UICollectionView!
    @IBOutlet weak var customInputView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let userInfoView = UserInfoNavBarView(name: "Basant Salama", image: nil)
        let userItem = UIBarButtonItem(customView: userInfoView)
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "chevron.backward"),
                style: .plain,
                target: self,
                action: #selector(handleBackButton)
            ),
            userItem
        ]
    }
    
    @objc private func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
