//
//  ConversationTableViewCell.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import Foundation
import UIKit

class ConversationTableViewCell: UITableViewCell {
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    
    var leadingConstraint: NSLayoutConstraint? = nil
    var trailingConstraint: NSLayoutConstraint? = nil
    
    var isIncoming: Bool? {
        didSet {
            if self.isIncoming ?? false {
                bubbleBackgroundView.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
              
            }
            else{
                bubbleBackgroundView.backgroundColor = UIColor(red: 220/255, green: 247/255, blue: 197/255, alpha: 1)
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //bubble
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.layer.cornerRadius = 10
        addSubview(bubbleBackgroundView)
        
        //message
        addSubview(messageLabel)
        if Int.random(in: 0..<2) == 0 {
            messageLabel.text = "ok"
        }
        else {
            messageLabel.text = Mock.sampleText
        }
       
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75, constant: -64),
           // messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75, constant: -32),
            
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
