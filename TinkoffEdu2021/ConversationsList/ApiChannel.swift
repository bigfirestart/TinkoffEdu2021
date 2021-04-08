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
                snapshot?.documentChanges.forEach { diff in
                    let identifier = diff.document.documentID
                    if diff.type == .removed {
                        let request: NSFetchRequest<DBChannel>  = DBChannel.fetchRequest()
                        request.predicate = NSPredicate(format: "identifier == %@", identifier)
                        do {
                            let result = try context.fetch(request)
                            context.delete(result[0])
                            
                        } catch {
                            fatalError("No delinion fetch")
                        }
                    } else {
                        let data = diff.document.data()
                        let name = data["name"] as? String ?? "Sample Name"
                        let lastMessage = data["lastMessage"] as? String
                        let lastActivity = (data["lastActivity"] as? Timestamp)?.dateValue()
                        _ = DBChannel(identifier: identifier,
                                                name: name,
                                                lastMessage: lastMessage,
                                                lastActivity: lastActivity,
                                                in: context)
                    }
                }
            })
        }
    }
    }
}
