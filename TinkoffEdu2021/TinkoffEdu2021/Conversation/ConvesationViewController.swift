//
//  ConvesationViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 03.03.2021.
//

import UIKit

class ConversationViewController: UIViewController {
    var conversationTable =  UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(conversationTable)
        
        conversationTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        conversationTable.translatesAutoresizingMaskIntoConstraints = false
        conversationTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        conversationTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        conversationTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        conversationTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        conversationTable.dataSource = self
        conversationTable.register(ConversationTableViewCell.self, forCellReuseIdentifier: "ConversationCell")
    }
}

extension ConversationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Mock.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: Mock.messages[indexPath.row])
        
        return cell
    }
}
