//
//  CoreDataChannel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 07.04.2021.
//

import Foundation

class CDChannelController {
    func dbGetChannels() {
        
    }
    
    func dbDeleteChannel() {
        
    }
    
    static func dbSaveChannels(coreDataStack: CoreDataStack, channels: [Channel]) {
        coreDataStack.performSave { context in
            for channel in channels {
                 _ = DBChannel(identifier: channel.identifier,
                                          name: channel.name,
                                          lastMessage: channel.lastMessage,
                                          lastActivity: channel.lastActivity,
                                          in: context)
            }
        }
    }
}
