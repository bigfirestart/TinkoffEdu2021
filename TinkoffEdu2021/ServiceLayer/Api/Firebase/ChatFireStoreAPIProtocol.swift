//
//  ChatFireStoreAPIProtocol.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 05.05.2021.
//

import Foundation

protocol ChatFireStoreAPIProtocol {
    init(coreDataStack: CoreDataStack)
    
    func getChannels()
    func createChannel(channelName: String)
    func deleteChannel(id: String)
    func getChannelMessages(channelId: String)
    func addMessageToChannel(documentId: String, message: String)
}
