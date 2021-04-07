//
//  CoreDataChannel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 07.04.2021.
//

import Foundation
import CoreData

class CDChannelController {
    static func dbGetChannels(context: NSManagedObjectContext, id: String) {
    }
    
    static func dbDeleteChannel(context: NSManagedObjectContext, id: String) {
        context.perform {
            do {
                let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
                request.predicate = NSPredicate(format: "identifier == %@", id)
                let result = try context.fetch(request)
                context.delete(result[0])
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
      
    }
    
    static func dbSaveChannels(context: NSManagedObjectContext, channels: [DBChannel]) {
        context.perform {
            do {
                let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
                let result = try context.fetch(request)
                for newChannel in channels {
                    if result.contains(newChannel) {
                        print("Contains: \(String(describing: newChannel.identifier))")
                    } else {
                        print("Not: \(String(describing: newChannel.name))")
                    }
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
    }
}
