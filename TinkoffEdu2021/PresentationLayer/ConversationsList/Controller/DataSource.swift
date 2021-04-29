//
//  TableViewDataSource.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 07.04.2021.
//

import UIKit
import CoreData

class ConversationsTableViewDataSource: NSObject, UITableViewDataSource {
    let fetchedResultsController: NSFetchedResultsController<DBChannel>
    let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack, fetchedResultsController: NSFetchedResultsController<DBChannel>) {
        self.fetchedResultsController = fetchedResultsController
        self.coreDataStack = coreDataStack
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath)
        guard let cell = tableCell as? ConversationsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: fetchedResultsController.object(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = fetchedResultsController.object(at: indexPath).identifier {
                ChatFireStoreAPI(coreDataStack: coreDataStack).deleteChannel(id: id)
            }
        }
    }
}
