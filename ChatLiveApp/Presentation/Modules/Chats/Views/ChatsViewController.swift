
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
