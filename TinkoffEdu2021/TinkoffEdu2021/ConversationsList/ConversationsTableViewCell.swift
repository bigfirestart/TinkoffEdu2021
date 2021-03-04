//
//  ConversationsTableViewCell.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 04.03.2021.
//

import Foundation
import UIKit


class ConversationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMessageDateLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    func configure(with configModel: ConversationCellConfiguration){
        userNameLabel.text = configModel.name
        lastMessageLabel.text = configModel.message
        
        
        if configModel.message == nil {
            lastMessageLabel.text = "No messages yet"
            lastMessageLabel.font = UIFont.italicSystemFont(ofSize: lastMessageLabel.font.pointSize)
        }
        else {
            lastMessageLabel.text = configModel.message
        }
        
        if configModel.online {
            self.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 243/255, alpha: 1)
        }
        
        if configModel.hasUnreadMessages {
            lastMessageLabel.font = UIFont.boldSystemFont(ofSize: lastMessageLabel.font.pointSize)
        }
        
        if let lastMessageDate = configModel.date {
            let format = DateFormatter()
            if lastMessageDate < Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() {
                format.dateFormat = "dd.MM"
            }
            else {
                format.dateFormat = "HH:mm"
            }
            lastMessageDateLabel.text = format.string(from: lastMessageDate)
        }
        else {
            lastMessageDateLabel.text = "..."
        }
    }
}
