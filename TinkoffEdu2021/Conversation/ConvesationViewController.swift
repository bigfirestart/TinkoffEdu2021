//
//  ConvesationViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import UIKit

class ConversationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var conversationTable: UITableView!

    @IBOutlet weak var messageTextField: UITextField!

    @IBOutlet weak var messageSendBtn: UIButton!

    var channelConf: ConversationsCellConfiguration?
    var messagesConfigs: [ConversationCellConfiguration] = []
    var coreDataStack: CoreDataStack?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nameShow = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: nameShow, object: nil)
        let nameHide = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: nameHide, object: nil)

        if let channel = channelConf {
            title = channel.name
            getChannelMessages(documentId: channel.channelId, completion: { [weak self] messages in
                self?.messagesConfigs = []
                for message in messages {
                    let text = message.senderName + ": \n" + message.content
                    if let userId = UserDefaults.standard.object(forKey: "UserApiId") {
                        let conf = ConversationCellConfiguration(text: text,
                                                                 isIncoming: message.senderId != userId as? String)
                        self?.messagesConfigs.append(conf)
                    }

                }
                
                self?.coreDataStack?.performSave { context in
                    let dbchannel = DBChannel(identifier: channel.channelId,
                                              name: channel.name,
                                              lastMessage: channel.message,
                                              lastActivity: channel.date,
                                              in: context)
                    print("Count \(messages.count)")
                    for message in messages {
                        let msg = DBMessage(identifier: message.identifier,
                                            content: message.content,
                                            created: message.created,
                                            senderId: message.senderId,
                                            senderName: message.senderName,
                                            in: context)
                        dbchannel.addToMessages(msg)
                    }
                }
                
                self?.coreDataStack?.printMessagesInfo()
                self?.coreDataStack?.printChannelsInfo()
                
                DispatchQueue.main.async {
                    self?.conversationTable.reloadData()
                    self?.scrollToBottom()
                }
            })
        }

        conversationTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        messageSendBtn.addTarget(self, action: #selector(sendMessageButtonClicked), for: .touchUpInside)

        conversationTable.dataSource = self
        conversationTable.register(ConversationTableViewCell.self, forCellReuseIdentifier: "ConversationCell")

        messageTextField.delegate = self
    }

    func scrollToBottom() {
        if self.messagesConfigs.count > 0 {
            let indexPath = IndexPath(row: self.messagesConfigs.count - 1, section: 0)
            self.conversationTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ConversationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesConfigs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let usualCell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath)
        guard let cell = usualCell as? ConversationTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: messagesConfigs[indexPath.row])

        return cell
    }
}

class ConversationBackView: UIView { }
class UISeparatorView: UIView {}
