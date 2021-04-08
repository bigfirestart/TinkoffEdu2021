//
//  ConvesationViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import UIKit
import CoreData

class ConversationViewController: UIViewController,
                                  UITextFieldDelegate,
                                  NSFetchedResultsControllerDelegate {
    @IBOutlet weak var conversationTable: UITableView!

    @IBOutlet weak var messageTextField: UITextField!

    @IBOutlet weak var messageSendBtn: UIButton!

    var channel: DBChannel?
    var coreDataStack: CoreDataStack?
    
    var fetchedResultsController: NSFetchedResultsController<DBMessage>?
    private lazy var tableViewDataSource: UITableViewDataSource = {
        
        guard let context = coreDataStack?.container.viewContext
            else { fatalError("CoreDataStack missing") }
        let request: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        request.predicate = NSPredicate(format: "channel == %@", self.channel ?? DBChannel())
        request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        self.fetchedResultsController = frc
        frc.delegate = self
        guard let cds = coreDataStack
            else { fatalError("CoreDataStack missing") }
        return ConversationTableViewDataSource(coreDataStack: cds,
                                                fetchedResultsController: frc)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let nameShow = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: nameShow, object: nil)
        let nameHide = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: nameHide, object: nil)
        
        guard let cds = coreDataStack else { fatalError("CoreDataStack Missing") }
        guard let id = channel?.identifier else { fatalError("Channel Missing") }
        
        ChatFireStoreAPI(coreDataStack: cds).getChannelMessages(channelId: id)
        
        conversationTable.dataSource = tableViewDataSource
        
        conversationTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        messageSendBtn.addTarget(self, action: #selector(sendMessageButtonClicked), for: .touchUpInside)

        conversationTable.register(ConversationTableViewCell.self, forCellReuseIdentifier: "ConversationCell")

        messageTextField.delegate = self
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        guard let newIndexPath = newIndexPath else { return }
        switch type {
        case .insert:
            conversationTable.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            conversationTable.deleteRows(at: [indexPath], with: .automatic)
            conversationTable.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            conversationTable.deleteRows(at: [indexPath], with: .automatic)
        case .update:
            conversationTable.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError("Unnown type")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        UIView.performWithoutAnimation {
            self.conversationTable.beginUpdates()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        UIView.performWithoutAnimation {
            self.conversationTable.endUpdates()
        }
        self.scrollToBottom()
    }

    func scrollToBottom() {
        guard let chnl = channel else { fatalError("Channel Missing") }
        if let msgCount = coreDataStack?.getCountOfMessagesInChannels(channel: chnl) {
            if msgCount > 0 && (conversationTable.numberOfRows(inSection: 0) == msgCount ) {
                let indexPath = IndexPath(row: msgCount - 1, section: 0)
                self.conversationTable.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
}

class ConversationBackView: UIView { }
class UISeparatorView: UIView {}
