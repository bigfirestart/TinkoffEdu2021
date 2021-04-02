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

    func configure(with config: ConversationsCellConfiguration) {

        self.selectionStyle = .none

        userNameLabel.text = config.name
       
        if config.message == nil {
            lastMessageLabel.text = "No messages yet"
            lastMessageLabel.font = UIFont.italicSystemFont(ofSize: lastMessageLabel.font.pointSize)
        } else {
            lastMessageLabel.text = config.message
        }

//        if config.online {
//            self.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 243/255, alpha: 1)
//        }
//        else{
//            self.backgroundColor = .white
//        }

        if config.hasUnreadMessages {
            lastMessageLabel.font = UIFont.boldSystemFont(ofSize: lastMessageLabel.font.pointSize)
        } else {
            lastMessageLabel.font = UIFont.systemFont(ofSize: lastMessageLabel.font.pointSize)
        }

        if let lastMessageDate = config.date {

            let format = DateFormatter()
            format.dateFormat = "dd.MM"

            // check is day is same
            if format.string(from: lastMessageDate) == format.string(from: Date()) {
                format.dateFormat = "HH:mm"
            } else {
                format.dateFormat = "dd MMM"
            }

            lastMessageDateLabel.text = format.string(from: lastMessageDate)
        } else {
            lastMessageDateLabel.text = "..."
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = nil
        userNameLabel.text = nil
        lastMessageDateLabel.text = nil
        lastMessageLabel.text = nil
    }
}
