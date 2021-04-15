//
//  CoreDataStack.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 31.03.2021.
//

import Foundation
import CoreData

class CoreDataStack {
    private let dataBaseName = "Chat"
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataBaseName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                preconditionFailure("something went wrong \(error) \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    func performSave(block: (NSManagedObjectContext) -> Void) {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSOverwriteMergePolicy
        
        block(context)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    func getChannelsCount() -> Int {
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        do {
            let result = try container.newBackgroundContext().fetch(request)
            return result.count
        } catch {
            preconditionFailure("crashed channels count")
        }
       
    }
    
    func getCountOfMessagesInChannel(channel: DBChannel) -> Int {
        let request: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        request.predicate = NSPredicate(format: "channel == %@", channel)
        do {
            let result = try container.newBackgroundContext().fetch(request)
            return result.count
        } catch {
            preconditionFailure("crashed channels count")
        }
       
    }
}
