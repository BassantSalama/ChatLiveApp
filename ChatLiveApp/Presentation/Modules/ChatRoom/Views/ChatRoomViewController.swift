

import UIKit
import FirebaseAuth

class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var chatRoomCollectionView: UICollectionView!
    
    @IBOutlet weak var customInputView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    let repository = ChatRoomRepositoryImpl()
    var viewModel: ChatRoomViewModel!
    var chatPartnerName: String?
    var chatId: String!
    var currentUserId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChatRoomViewModel(chatRoomRepository: repository, chatId: chatId, currentUserId: currentUserId)
        setupNavigationBar()
        setupCollectionView()
        setupBindings()
        viewModel.observeMessages(chatId: chatId)
        viewModel.markMessagesAsRead()
    }
    
    private func setupCollectionView() {
        chatRoomCollectionView.dataSource = self
        chatRoomCollectionView.delegate = self
        chatRoomCollectionView.keyboardDismissMode = .interactive
        chatRoomCollectionView.register(UINib(nibName: "IncomingMessageCell", bundle: nil), forCellWithReuseIdentifier: "IncomingMessageCell")
        chatRoomCollectionView.register(UINib(nibName: "OutgoingMessageCell", bundle: nil), forCellWithReuseIdentifier: "OutgoingMessageCell")
    }
    
    private func setupBindings() {
        viewModel.onMessagesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.chatRoomCollectionView.reloadData()
                self?.scrollToBottom()
            }
        }
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        guard let content = inputTextField.text, !content.isEmpty else { return }
        viewModel.sendMessage(content: content)
        inputTextField.text = ""
    }
    
    private func scrollToBottom() {
        let count = viewModel.messages.count
        if count > 0 {
            let indexPath = IndexPath(item: count - 1, section: 0)
            chatRoomCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func setupNavigationBar() {
        let userInfoView = UserInfoNavBarView(name: chatPartnerName ?? "Chatting with", image: nil)
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

extension ChatRoomViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = viewModel.messages[indexPath.item]
        if viewModel.isMessageOutgoing(message) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutgoingMessageCell", for: indexPath) as! OutgoingMessageCell
            cell.configure(with: message.content)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IncomingMessageCell", for: indexPath) as! IncomingMessageCell
            cell.configure(with: message.content)
            return cell
        }
    }
}

extension ChatRoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = viewModel.messages[indexPath.item]
        let fullWidth = collectionView.bounds.width
        let maxBubbleWidth = fullWidth * 0.7
        let font = UIFont.systemFont(ofSize: 16)
        let textHeight = heightForMessage(text: message.content, font: font, maxWidth: maxBubbleWidth)
        let verticalPadding: CGFloat = 16
        return CGSize(width: fullWidth, height: textHeight + verticalPadding)
    }
    
    private func heightForMessage(text: String, font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let boundingBox = NSString(string: text).boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
}











