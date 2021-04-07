//
//  ChatInput.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 25.03.2021.
//

import Foundation
import UIKit

extension ConversationViewController {
    @objc func sendMessageButtonClicked() {
        view.endEditing(true)
        if let text = messageTextField.text {
            if text != "" {
                addMessageToChannel(documentId: channelConf?.identifier ?? "", message: text)
                messageTextField.text = ""
            }
        }
    }
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               let keyboardRectangle = keyboardFrame.cgRectValue
               let keyboardHeight = keyboardRectangle.height
               self.view.frame.origin.y = -1 * keyboardHeight
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendMessageButtonClicked()
        return true
    }
}
