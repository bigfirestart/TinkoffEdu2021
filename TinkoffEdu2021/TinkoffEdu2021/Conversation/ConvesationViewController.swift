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
    
    var channelConf: ConversationsCellConfiguration? = nil
    var messages: [ConversationCellConfiguration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        if let channel = channelConf {
            title = channel.name
            getChannelMessages(documentId: channel.channelId ?? "", completion: { [weak self] messages in
                self?.messages = []
                for message in messages {
                    let text = message.senderName + ": \n" + message.content
                    if let userId = UserDefaults.standard.object(forKey: "UserApiId"){
                        self?.messages.append(ConversationCellConfiguration(text: text,
                                                                            isIncoming: message.senderId != userId as? String))
                    }

                }
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
    
    
    func scrollToBottom(){
        if self.messages.count > 0 {
            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
            self.conversationTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ConversationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: messages[indexPath.row])
        
        return cell
    }
}

class ConversationBackView: UIView { }
class UISeparatorView: UIView {}
