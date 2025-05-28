
import UIKit
import FirebaseAuth

class ChatsViewController: UIViewController{
    
    @IBOutlet weak var chatsTableView: UITableView!
    private var viewModel: ChatsViewModel!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setupTableView()
           setupViewModel()
           bindViewModel()
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           loadChats()
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           viewModel.stopListening()
       }
       
       private func setupTableView() {
           chatsTableView.dataSource = self
           chatsTableView.delegate = self
       }
       
       private func setupViewModel() {
           let repository = ChatListRepositoryImpl()
           let useCase = FetchChatListUseCase(repository: repository)
           viewModel = ChatsViewModel(fetchChatListUseCase: useCase)
       }
       
       private func bindViewModel() {
           viewModel.onChatsUpdated = { [weak self] in
               DispatchQueue.main.async {
                   self?.chatsTableView.reloadData()
               }
           }
       }
       
       private func loadChats() {
           guard let currentUserId = Auth.auth().currentUser?.uid else { return }
           viewModel.loadChats(for: currentUserId)
       }
   }

   extension ChatsViewController: UITableViewDataSource {
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.chats.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let chat = viewModel.chats[indexPath.row]
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatTableViewCell else {
               return UITableViewCell()
           }
           cell.configure(with: chat)
           return cell
       }
   }

   extension ChatsViewController: UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedChat = viewModel.chats[indexPath.row]
           let storyboard = UIStoryboard(name: "ChatRoom", bundle: nil)
           if let chatRoomVC = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController") as? ChatRoomViewController {
               chatRoomVC.chatId = selectedChat.chatId
               chatRoomVC.currentUserId = Auth.auth().currentUser?.uid ?? ""
               chatRoomVC.chatPartnerName = selectedChat.userName
               chatRoomVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(chatRoomVC, animated: true)
           }
       }
   }
