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

    var model = ConversationModel()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let nameShow = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: nameShow, object: nil)
        let nameHide = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: nameHide, object: nil)
        
        guard let cds = model.coreDataStack else { fatalError("CoreDataStack Missing") }
        guard let id = model.channel?.identifier else { fatalError("Channel Missing") }
        
        ChatFireStoreAPI(coreDataStack: cds).getChannelMessages(channelId: id)
        
        conversationTable.dataSource = model.tableViewDataSource
        model.fetchedResultsController?.delegate = self
        
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
        switch type {
        case .insert:
            if let index = newIndexPath {
                conversationTable.insertRows(at: [index], with: .automatic)
            }
        case .move:
            if let index = indexPath {
                if let newIndex = newIndexPath {
                    conversationTable.deleteRows(at: [index], with: .automatic)
                    conversationTable.insertRows(at: [newIndex], with: .automatic)
                }
            }
        case .delete:
            if let index = indexPath {
                conversationTable.deleteRows(at: [index], with: .automatic)
            }
        case .update:
            if let index = indexPath {
                conversationTable.reloadRows(at: [index], with: .automatic)
            }
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
        guard let chnl = model.channel else { fatalError("Channel Missing") }
        if let msgCount = model.coreDataStack?.getCountOfMessagesInChannel(channel: chnl) {
            if msgCount > 0 && (conversationTable.numberOfRows(inSection: 0) == msgCount ) {
                let indexPath = IndexPath(row: msgCount - 1, section: 0)
                self.conversationTable.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
}

class ConversationBackView: UIView { }
class UISeparatorView: UIView {}
