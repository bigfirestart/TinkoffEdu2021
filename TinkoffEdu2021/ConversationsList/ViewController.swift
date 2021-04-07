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
    var channels: [ConversationsCellConfiguration] = []
    var coreDataStack = CoreDataStack()
    
    var fetchedResultsController: NSFetchedResultsController<DBChannel>?
    private lazy var tableViewDataSource: UITableViewDataSource = {
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lastActivity", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: coreDataStack.mainContext,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
        self.fetchedResultsController = frc
        frc.delegate = self
        return ConversationsTableViewDataSource(fetchedResultsController: frc)
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        if let index = newIndexPath {
            switch type {
            case .insert:
                conversationsTable.insertRows(at: [index], with: .automatic)
            case .move:
                conversationsTable.deleteRows(at: [index], with: .automatic)
                conversationsTable.insertRows(at: [index], with: .automatic)
            case .delete:
                conversationsTable.deleteRows(at: [index], with: .automatic)
            default: break
            }
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.conversationsTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.conversationsTable.endUpdates()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getChannels(context: coreDataStack.mainContext, completion: { [weak self] channels in
            CDChannelController.dbSaveChannels(
                context: self?.coreDataStack.mainContext ?? NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
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
        
        if let frc = self.fetchedResultsController {
            conversationVC.channelConf = frc.object(at: indexPath)
            navigationController?.pushViewController(conversationVC, animated: true)
        }
    }
}

extension ConversationsListViewController: ThemesPickerDelegate {
    func didChangeTheme(_ theme: Theme) {
        ThemeManager.apply(theme, application: UIApplication.shared)
    }
}
