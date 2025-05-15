
import UIKit

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var chatsTableView: UITableView!
    
    let dummyData = [
        (username: "Basant", message: "Hello there "),
        (username: "Ebrahim", message: "How can I help you?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsTableView.dataSource = self
        chatsTableView.delegate = self
    }
}
extension ChatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dummyData[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.userNameLabel.text = item.username
        cell.lastMassageLabel.text = item.message
        return cell
    }
}
extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ChatRoom", bundle: nil)
        if let chatRoomVC = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController") as? ChatRoomViewController {
            chatRoomVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(chatRoomVC, animated: true)
        }
        
    }
}
