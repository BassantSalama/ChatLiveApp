
import UIKit

class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var chatRoomCollectionView: UICollectionView!
    @IBOutlet weak var customInputView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    let dummyMessages = [
        (message: "Hello!", isIncoming: true),
        (message: "Hi, how are you?", isIncoming: false),
        (message: "I'm fine, thank you!", isIncoming: true),
        (message: "Hello!", isIncoming: true),
        (message: "Hi, how are you?", isIncoming: false),
        (message: "I'm fine, thank you!", isIncoming: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        chatRoomCollectionView.dataSource = self
        chatRoomCollectionView.delegate = self
        
        registerCells()
        configureCollectionViewLayout()
    }
    
    private func registerCells() {
        chatRoomCollectionView.register(UINib(nibName: "IncomingMessageCell", bundle: nil), forCellWithReuseIdentifier: "IncomingMessageCell")
        chatRoomCollectionView.register(UINib(nibName: "OutgoingMessageCell", bundle: nil), forCellWithReuseIdentifier: "OutgoingMessageCell")
    }
    
    private func configureCollectionViewLayout() {
        if let layout = chatRoomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumLineSpacing = 8
        }
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

extension ChatRoomViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = dummyMessages[indexPath.item]
        
        if message.isIncoming {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IncomingMessageCell", for: indexPath) as! IncomingMessageCell
            cell.configure(with: message.message)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutgoingMessageCell", for: indexPath) as! OutgoingMessageCell
            cell.configure(with: message.message)
            return cell
        }
    }
    
}
