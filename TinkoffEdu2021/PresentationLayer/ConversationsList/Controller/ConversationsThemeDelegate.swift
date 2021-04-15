//
//  ConversationsThemeDelegate.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 15.04.2021.
//

import Foundation
import UIKit

extension ConversationsListViewController: ThemesPickerDelegate {
    func didChangeTheme(_ theme: Theme) {
        ThemeManager.apply(theme, application: UIApplication.shared)
    }
}
