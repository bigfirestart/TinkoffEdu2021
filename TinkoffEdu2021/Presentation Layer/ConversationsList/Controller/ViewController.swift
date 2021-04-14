//
//  ConversationsListViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import UIKit
import Foundation
import Firebase
import CoreData

class ConversationsListViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var conversationsTable: UITableView!
    @IBOutlet weak var addChannelBtn: UIButton!
    
    var model = ConversationsModel()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let index = newIndexPath {
                conversationsTable.insertRows(at: [index], with: .automatic)
            }
        case .move:
            if let index = indexPath {
                if let newIndex = newIndexPath {
                    conversationsTable.deleteRows(at: [index], with: .automatic)
                    conversationsTable.insertRows(at: [newIndex], with: .automatic)
                }
            }
        case .delete:
            if let index = indexPath {
                conversationsTable.deleteRows(at: [index], with: .automatic)
            }
        case .update:
            if let index = indexPath {
                conversationsTable.reloadRows(at: [index], with: .automatic)
            }
        default:
            fatalError("Unnown type")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        UIView.performWithoutAnimation {
            self.conversationsTable.beginUpdates()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        UIView.performWithoutAnimation {
            self.conversationsTable.endUpdates()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: CoreData
        ChatFireStoreAPI(coreDataStack: model.coreDataStack).getChannels()

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
        conversationsTable.dataSource = model.tableViewDataSource
        model.fetchedResultsController?.delegate = self
        conversationsTable.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToThemes" {
            guard let settings = segue.destination as? SettingsViewController else { return }

            settings.themeDelegate = self
        }
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConversationViewController")
        let conversationVC = viewController as? ConversationViewController ?? ConversationViewController()
        conversationVC.model.coreDataStack = model.coreDataStack
        
        guard let frc = model.fetchedResultsController else { fatalError("Fetch Missing")}
        conversationVC.model.channel = frc.object(at: indexPath)
        navigationController?.pushViewController(conversationVC, animated: true)
      
    }
}

extension ConversationsListViewController: ThemesPickerDelegate {
    func didChangeTheme(_ theme: Theme) {
        ThemeManager.apply(theme, application: UIApplication.shared)
    }
}
