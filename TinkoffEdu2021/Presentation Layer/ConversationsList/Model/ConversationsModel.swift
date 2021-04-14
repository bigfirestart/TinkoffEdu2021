//
//  ConversationsModel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 14.04.2021.
//

import Foundation
import UIKit
import CoreData

class ConversationsModel {
    var coreDataStack = CoreDataStack()
    
    var fetchedResultsController: NSFetchedResultsController<DBChannel>?
    lazy var tableViewDataSource: UITableViewDataSource = {
        
        let context = coreDataStack.container.viewContext
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lastActivity", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        self.fetchedResultsController = frc
        return ConversationsTableViewDataSource(coreDataStack: coreDataStack, fetchedResultsController: frc)
    }()
}
