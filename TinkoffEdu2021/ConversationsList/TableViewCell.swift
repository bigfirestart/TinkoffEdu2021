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

    func configure(with config: DBChannel) {

        self.selectionStyle = .none

        userNameLabel.text = config.name
       
        if config.lastMessage == nil {
            lastMessageLabel.text = "No messages yet"
            lastMessageLabel.font = UIFont.italicSystemFont(ofSize: lastMessageLabel.font.pointSize)
        } else {
            lastMessageLabel.text = config.lastMessage
        }

        if let lastMessageDate = config.lastActivity {

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
