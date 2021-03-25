//
//  ConversationTableViewCell.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import Foundation
import UIKit

class ConversationTableViewCell: UITableViewCell {
    let messageLabel = TheamedUILabel()
    let userLabel = TheamedUILabel()
    let bubbleBackgroundView = UIView()

    static var leftBubbleColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    static var rigthBubbleColor = UIColor(red: 220/255, green: 247/255, blue: 197/255, alpha: 1)

    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?

    func configure(with config: ConversationCellConfiguration) {
        if config.text == nil {
            messageLabel.text = "..."
            userLabel.text = "User"
        } else {
            messageLabel.text = config.text
        }

        if config.isIncoming {
            bubbleBackgroundView.backgroundColor = ConversationTableViewCell.leftBubbleColor
            leadingConstraint?.isActive = true
            trailingConstraint?.isActive = false
        } else {
            bubbleBackgroundView.backgroundColor = ConversationTableViewCell.rigthBubbleColor
            leadingConstraint?.isActive = false
            trailingConstraint?.isActive = true
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // bubble
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.layer.cornerRadius = 10
        addSubview(bubbleBackgroundView)

        // message
        addSubview(messageLabel)
        addSubview(userLabel)

        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75, constant: -64),

            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)

        ]

        NSLayoutConstraint.activate(constraints)

        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChatInputStackView: UIStackView {}
