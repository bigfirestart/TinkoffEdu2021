//
//  ConversationAddChannel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 24.03.2021.
//

import Foundation
import UIKit

extension ConversationsListViewController {
    @objc func addChannelClicked() {
        let alert = UIAlertController(title: "Create new channel", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {_ in })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            if let text = alert?.textFields?[0].text {
                ChatFireStoreAPI(coreDataStack: self.model.coreDataStack).createChannel(channelName: text)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
