//
//  ConversationsListViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import UIKit
import Foundation

class ConversationsListViewController: UIViewController{
    @IBOutlet weak var conversationsTable: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Tinkoff Chat"
        
        conversationsTable.dataSource = self
        conversationsTable.delegate = self
        
    }
}

extension ConversationsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return Mock.onlineConversationsList.count
            case 1:
                return Mock.historyConversationsList.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Online"
            case 1:
                return "History"
            default:
                return ""
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Keks", for: indexPath) as? ConversationsTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
            case 0:
                cell.configure(with: Mock.onlineConversationsList[indexPath.row])
            case 1:
                cell.configure(with: Mock.historyConversationsList[indexPath.row])
            default:
                break
        }
       
        return cell
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationViewController = ConversationViewController()
        conversationViewController.title = Mock.onlineConversationsList[indexPath.row].name
        navigationController?.pushViewController(conversationViewController, animated: true)
    }
}
