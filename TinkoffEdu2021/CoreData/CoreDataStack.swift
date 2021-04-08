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
                fatalError("something went wrong \(error) \(error.userInfo)")
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
            fatalError("crashed channels count")
        }
       
    }
    
    func getCountOfMessagesInChannels(channelId: String) -> Int {
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", channelId)
        do {
            let result = try container.newBackgroundContext().fetch(request)
            print(result)
            return result[0].messages?.count ?? 0
        } catch {
            fatalError("crashed channels count")
        }
       
    }
}
