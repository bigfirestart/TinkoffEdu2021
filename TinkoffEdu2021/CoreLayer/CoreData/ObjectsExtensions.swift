//
//  ObjectsExtensions.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 31.03.2021.
//

import Foundation
import CoreData

extension DBChannel {
    convenience init(identifier: String, name: String, lastMessage: String?,
                     lastActivity: Date?, in context: NSManagedObjectContext) {
        self.init(context: context)
        self.identifier = identifier
        self.name = name
        self.lastMessage = lastMessage
        self.lastActivity = lastActivity
    }
}

extension DBMessage {
    convenience init(identifier: String,
                     content: String,
                     created: Date,
                     senderId: String,
                     senderName: String,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.identifier = identifier
        self.content = content
        self.created = created
        self.senderId = senderId
        self.senderName = senderName
    }
}
