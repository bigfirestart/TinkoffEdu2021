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
        
        switch UserDefaults.standard.object(forKey: "Theme") as? String {
            case "Classic":
                ThemeManager.apply(.classic, application: UIApplication.shared)
            case "Day":
                ThemeManager.apply(.day, application: UIApplication.shared)
            case "Night":
                ThemeManager.apply(.night, application: UIApplication.shared)
            case .none:
                break
            case .some(_):
                break
        }
       
        title = "Tinkoff Chat"
        conversationsTable.dataSource = self
        conversationsTable.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToThemes" {
            guard let settings = segue.destination as? SettingsViewController else { return }
            
            settings.themeDelegate = self
//            settings.themeHandler = { (theme: Theme) -> () in
//                ThemeManager.apply(theme, application: UIApplication.shared)
//                print(theme)
//            }
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath) as? ConversationsTableViewCell else {
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
        switch indexPath.section {
            case 0:
                conversationViewController.title = Mock.onlineConversationsList[indexPath.row].name
            case 1:
                conversationViewController.title = Mock.historyConversationsList[indexPath.row].name
            default:
                break
        }
       
        navigationController?.pushViewController(conversationViewController, animated: true)
    }
}


extension ConversationsListViewController: ThemesPickerDelegate {
    func didChangeTheme(_ theme: Theme) {
        ThemeManager.apply(theme, application: UIApplication.shared)
    }
}

