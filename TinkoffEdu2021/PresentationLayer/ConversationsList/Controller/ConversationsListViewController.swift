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
    
    var chatFireStoreAPI: ChatFireStoreAPIProtocol
    var model: ConversationsModel
    
    // custom init
    init(model: ConversationsModel, chatFireStoreAPI: ChatFireStoreAPIProtocol) {
        self.model = model
        self.chatFireStoreAPI = chatFireStoreAPI
        super.init(nibName: nil, bundle: nil)
    }
    
    // init from storyboard
    required init?(coder aDecoder: NSCoder) {
        print("init from storyboard")
        self.model = ConversationsModel(coreDataStack: CoreDataStack())
        self.chatFireStoreAPI = Tinkoff_Edu.ChatFireStoreAPI(coreDataStack: self.model.coreDataStack)
        super.init(coder: aDecoder)
    }
    
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
            return
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
    func getChannels() {
        self.chatFireStoreAPI.getChannels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: CoreData
        getChannels()

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
