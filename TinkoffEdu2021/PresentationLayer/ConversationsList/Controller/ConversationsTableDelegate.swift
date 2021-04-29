//
//  ConversationsTableDelegate.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 15.04.2021.
//

import Foundation
import UIKit

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConversationViewController")
        let conversationVC = viewController as? ConversationViewController ?? ConversationViewController()
        conversationVC.model.coreDataStack = model.coreDataStack
        
        guard let frc = model.fetchedResultsController else { return }
        conversationVC.model.channel = frc.object(at: indexPath)
        navigationController?.pushViewController(conversationVC, animated: true)
      
    }
}
