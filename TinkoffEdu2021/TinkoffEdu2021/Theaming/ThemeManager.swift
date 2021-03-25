//
//  ThemeManager.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 11.03.2021.
//

import Foundation
import UIKit

struct ThemeManager {
    static func apply(_ theme: Theme, application: UIApplication) {
        TheamedUILabel.appearance().textColor = theme.appTheme.textColor
        TheamedUIView.appearance().backgroundColor = theme.appTheme.backgroundColor
        TheamedUIButton.appearance().backgroundColor = theme.appTheme.navColor
        
        UITableView.appearance().backgroundColor = theme.appTheme.backgroundColor
        UITableView.appearance().tintColor = theme.appTheme.navColor
        UITextView.appearance().backgroundColor = theme.appTheme.backgroundColor
        UIActivityIndicatorView.appearance().color = theme.appTheme.textColor
        
        //nav
        UINavigationBar.appearance().barTintColor = theme.appTheme.navColor
        UINavigationBar.appearance().tintColor = theme.appTheme.textColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.appTheme.textColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: theme.appTheme.textColor]
        
        
        //conversation
        ConversationTableViewCell.appearance().backgroundColor = theme.appTheme.backgroundColor
        ConversationTableViewCell.leftBubbleColor = theme.appTheme.leftBubbleColor
        ConversationTableViewCell.rigthBubbleColor = theme.appTheme.rigthBubbleColor
        
        //conversation list
        ConversationsTableViewCell.appearance().backgroundColor = theme.appTheme.backgroundColor
        
        if #available(iOS 13.0, *) {
            application.keyWindow?.overrideUserInterfaceStyle = theme.appTheme.userIntefaceStyle
        }
        
        application.keyWindow?.reload()
        
    }
}

public extension UIWindow {
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}

