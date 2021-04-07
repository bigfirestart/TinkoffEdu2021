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
    
    init(fetchedResultsController: NSFetchedResultsController<DBChannel>) {
        self.fetchedResultsController = fetchedResultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Perform fetch throw \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections")
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
    
}
