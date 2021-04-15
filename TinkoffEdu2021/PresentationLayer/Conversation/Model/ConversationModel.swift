//
//  ConversationModel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 14.04.2021.
//

import Foundation
import UIKit
import CoreData

struct ConversationModel {
    var channel: DBChannel?
    var coreDataStack: CoreDataStack?
    
    var fetchedResultsController: NSFetchedResultsController<DBMessage>?
    lazy var tableViewDataSource: UITableViewDataSource = {
        
        guard let context = coreDataStack?.container.viewContext
            else { fatalError("CoreDataStack missing") }
        let request: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        request.predicate = NSPredicate(format: "channel == %@", self.channel ?? DBChannel())
        request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        self.fetchedResultsController = frc
        guard let cds = coreDataStack
            else { fatalError("CoreDataStack missing") }
        return ConversationTableViewDataSource(coreDataStack: cds,
                                                fetchedResultsController: frc)
    }()
}
