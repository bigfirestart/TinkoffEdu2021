//
//  ChatFireStoreAPI.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 08.04.2021.
//

import Foundation
import Firebase
import CoreData

class ChatFireStoreAPI: ChatFireStoreAPIProtocol {
    let coreDataStack: CoreDataStack
    
    required init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Channels
    func getChannels() {
        let reference = Firestore.firestore().collection("channels")
        reference.addSnapshotListener { snapshot, _ in
        DispatchQueue.global(qos: .utility).async {
            self.coreDataStack.performSave(block: { (context) in
                snapshot?.documentChanges.forEach { diff in
                    let identifier = diff.document.documentID
                    let data = diff.document.data()
                    switch diff.type {
                    case .removed:
                        let request: NSFetchRequest<DBChannel>  = DBChannel.fetchRequest()
                        request.predicate = NSPredicate(format: "identifier == %@", identifier)
                        do {
                            let result = try context.fetch(request)
                            context.delete(result[0])
                            
                        } catch {
                            preconditionFailure("No delinion fetch")
                        }
                    case .added:
                        let name = data["name"] as? String ?? "Sample Name"
                        let lastMessage = data["lastMessage"] as? String
                        let lastActivity = (data["lastActivity"] as? Timestamp)?.dateValue()
                        _ = DBChannel(identifier: identifier,
                                                name: name,
                                                lastMessage: lastMessage,
                                                lastActivity: lastActivity,
                                                in: context)
                    case .modified:
                        let lastMessage = data["lastMessage"] as? String
                        let lastActivity = (data["lastActivity"] as? Timestamp)?.dateValue()
                        let request: NSFetchRequest<DBChannel>  = DBChannel.fetchRequest()
                        request.predicate = NSPredicate(format: "identifier == %@", identifier)
                        do {
                            let result = try context.fetch(request)
                            result[0].lastActivity = lastActivity
                            result[0].lastMessage = lastMessage
                            
                        } catch {
                            preconditionFailure("No delinion fetch")
                        }
                    }
                    }
                })
            }
        }
    }
    
    func createChannel(channelName: String) {
        if channelName != "" {
            let reference = Firestore.firestore().collection("channels")
            reference.addDocument(data: ["name": channelName, "lastActivity": Date()])
        }
    }

    func deleteChannel(id: String) {
        let reference = Firestore.firestore().collection("channels")
        reference.document(id).delete()
    }
    
    // MARK: - Messages
    
    func getChannelMessages(channelId: String) {
        let reference = Firestore.firestore().collection("channels")
                                 .document(channelId).collection("messages")

        reference.addSnapshotListener { snapshot, _ in
            self.coreDataStack.performSave(block: { (context) in
                snapshot?.documentChanges.forEach { diff in
                    let identifier = diff.document.documentID
                    if diff.type == .removed {
                        let request: NSFetchRequest<DBMessage>  = DBMessage.fetchRequest()
                        request.predicate = NSPredicate(format: "identifier == %@", identifier)
                        do {
                            let result = try context.fetch(request)
                            context.delete(result[0])
                            
                        } catch {
                            preconditionFailure("No delinion fetch")
                        }
                    } else {
                        let data = diff.document.data()
                        let content = data["content"] as? String ?? "..."
                        let created = (data["created"] as? Timestamp)?.dateValue() ?? Date()
                        let senderId = data["senderId"] as? String ?? ""
                        let senderName = data["senderName"] as? String ?? "Unknown"
                        let msg = DBMessage(identifier: identifier,
                                  content: content,
                                  created: created,
                                  senderId: senderId,
                                  senderName: senderName,
                                  in: context)
                        
                        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
                        request.predicate = NSPredicate(format: "identifier == %@", channelId)
                        do {
                            let res = try context.fetch(request)
                            res[0].addToMessages(msg)
                        } catch {
                            assertionFailure(error.localizedDescription)
                        }
                    }
                }
            })
        }
    }
    
    func addMessageToChannel(documentId: String, message: String) {
        let reference = Firestore.firestore().collection("channels").document(documentId).collection("messages")
        if let userId = UserDefaults.standard.object(forKey: "UserApiId") {
            reference.addDocument(data: ["content": message,
                                         "created": Date(),
                                         "senderName": "bigfirestart",
                                         "senderId": userId])
        }

    }

}
