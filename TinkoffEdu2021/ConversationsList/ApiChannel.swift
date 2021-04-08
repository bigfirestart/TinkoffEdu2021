//
//  ApiChannel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 08.04.2021.
//

import Foundation
import UIKit
import CoreData
import Firebase

extension ConversationsListViewController {
    func getChannels() {
        let reference = Firestore.firestore().collection("channels")
        reference.addSnapshotListener { snapshot, _ in
        DispatchQueue.global(qos: .utility).async {
            self.coreDataStack.performSave(block: { (context) in
                var channels: [DBChannel] = []
                if let documents = snapshot?.documents {
                    for document in documents {
                        let data = document.data()

                        let identifier = document.documentID
                        let name = data["name"] as? String ?? "Sample Name"
                        let lastMessage = data["lastMessage"] as? String
                        let lastActivity = (data["lastActivity"] as? Timestamp)?.dateValue()
                        let channel = DBChannel(identifier: identifier,
                                              name: name,
                                              lastMessage: lastMessage,
                                              lastActivity: lastActivity,
                                              in: context)
                        channels.append(channel)
                    }
                }
                print(self.coreDataStack.getChannelsCount())
            })
        }
    }
    }
}
