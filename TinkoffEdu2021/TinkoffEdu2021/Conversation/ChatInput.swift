//
//  ChatInput.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 25.03.2021.
//

import Foundation

extension ConversationViewController {
    @objc func sendMessageButtonClicked(){
        if let text = messageTextField.text {
            if text != "" {
                addMessageToChannel(documentId: channelConf?.channelId ?? "", message: text)
                messageTextField.text = ""
            }
        }
    }
}
