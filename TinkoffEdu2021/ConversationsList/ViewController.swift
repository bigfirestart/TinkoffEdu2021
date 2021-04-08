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
    var coreDataStack = CoreDataStack()
    
    var fetchedResultsController: NSFetchedResultsController<DBChannel>?
    private lazy var tableViewDataSource: UITableViewDataSource = {
        
        let context = coreDataStack.container.viewContext
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lastActivity", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        self.fetchedResultsController = frc
        frc.delegate = self
        return ConversationsTableViewDataSource(coreDataStack: coreDataStack, fetchedResultsController: frc)
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        guard let newIndexPath = newIndexPath else { return }
        switch type {
        case .insert:
            conversationsTable.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            conversationsTable.deleteRows(at: [indexPath], with: .automatic)
            conversationsTable.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            conversationsTable.deleteRows(at: [indexPath], with: .automatic)
        case .update:
            conversationsTable.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
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
        ChatFireStoreAPI(coreDataStack: coreDataStack).getChannels()

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
        conversationsTable.dataSource = tableViewDataSource
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
        conversationVC.coreDataStack = self.coreDataStack
        
        guard let frc = self.fetchedResultsController else { fatalError("Fetch Missing")}
        conversationVC.channel = frc.object(at: indexPath)
        navigationController?.pushViewController(conversationVC, animated: true)
      
    }
}

extension ConversationsListViewController: ThemesPickerDelegate {
    func didChangeTheme(_ theme: Theme) {
        ThemeManager.apply(theme, application: UIApplication.shared)
    }
}
