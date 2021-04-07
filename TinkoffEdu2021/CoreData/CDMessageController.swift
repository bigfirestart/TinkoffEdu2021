//
//  CDMessageController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 07.04.2021.
//

import Foundation

class CDMessageController {
    static func dbSaveMessages(coreDataStack: CoreDataStack,
                               channel: ConversationsCellConfiguration,
                               messages: [Message]) {
        coreDataStack.performSave { context in
            let dbchannel = DBChannel(identifier: channel.channelId,
                                      name: channel.name,
                                      lastMessage: channel.message,
                                      lastActivity: channel.date,
                                      in: context)
            for message in messages {
                let msg = DBMessage(identifier: message.identifier,
                                    content: message.content,
                                    created: message.created,
                                    senderId: message.senderId,
                                    senderName: message.senderName,
                                    in: context)
                dbchannel.addToMessages(msg)
            }
        }
    }
}
