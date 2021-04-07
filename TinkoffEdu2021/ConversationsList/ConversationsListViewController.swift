//
//  ConversationsListViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import UIKit
import Foundation
import Firebase

class ConversationsListViewController: UIViewController {
    @IBOutlet weak var conversationsTable: UITableView!
    @IBOutlet weak var addChannelBtn: UIButton!
    var channels: [ConversationsCellConfiguration] = []
    
    var coreDataStack = CoreDataStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getChannels(completion: { [weak self] channels in
            self?.channels = []
            for channel in channels {
                self?.channels.append(ConversationsCellConfiguration(channelId: channel.identifier,
                                                                     name: channel.name,
                                                                     message: channel.lastMessage,
                                                                     date: channel.lastActivity,
                                                                     online: false,
                                                                     hasUnreadMessages: false))
            }
            
            CDChannelController.dbSaveChannels(coreDataStack: self?.coreDataStack ?? CoreDataStack(),
                                               channels: channels)
            self?.coreDataStack.printChannelsInfo()
            
            DispatchQueue.main.async {
                self?.conversationsTable.reloadData()
            }
        })
        
        // MARK: CoreData
        coreDataStack.enableObservers()

        addChannelBtn.addTarget(self, action: #selector(addChannelClicked), for: .touchUpInside)

        switch UserDefaults.standard.object(forKey: "Theme") as? String {
        case "Classic":
            ThemeManager.apply(.classic, application: UIApplication.shared)
        case "Day":
            ThemeManager.apply(.day, application: UIApplication.shared)
        case "Night":
            ThemeManager.apply(.night, application: UIApplication.shared)
        case .none:
            break
        case .some:
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
        }
    }
}

extension ConversationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Channels"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath)
        guard let cell = tableCell as? ConversationsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: channels[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = channels[indexPath.row].channelId
            channels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteChannel(id: id)
        }
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConversationViewController")
        let conversationVC = viewController as? ConversationViewController ?? ConversationViewController()
        conversationVC.coreDataStack = self.coreDataStack
        conversationVC.channelConf = channels[indexPath.row]
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}

extension ConversationsListViewController: ThemesPickerDelegate {
    func didChangeTheme(_ theme: Theme) {
        ThemeManager.apply(theme, application: UIApplication.shared)
    }
}
