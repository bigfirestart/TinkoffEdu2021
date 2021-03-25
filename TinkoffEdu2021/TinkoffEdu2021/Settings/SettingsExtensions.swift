//
//  SettingsExtensions.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 09.03.2021.
//

import Foundation
import UIKit

extension SettingsViewController {
    func themePreviewBtnAddSubviews(parentBtnView: UIButton, leftColor: UIColor, rightColor: UIColor) {
        let dialogLeftSample = UIView()
        let dialogRightSample = UIView()

        parentBtnView.addSubview(dialogLeftSample)
        parentBtnView.addSubview(dialogRightSample)

        dialogLeftSample.translatesAutoresizingMaskIntoConstraints = false
        dialogRightSample.translatesAutoresizingMaskIntoConstraints = false

        // left
        dialogLeftSample.backgroundColor = leftColor
        dialogLeftSample.widthAnchor.constraint(equalToConstant: 117).isActive = true
        dialogLeftSample.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dialogLeftSample.layer.cornerRadius = 10
        dialogLeftSample.leadingAnchor.constraint(equalTo: parentBtnView.leadingAnchor, constant: 27).isActive = true
        dialogLeftSample.topAnchor.constraint(equalTo: parentBtnView.topAnchor, constant: 10).isActive = true

        dialogLeftSample.isUserInteractionEnabled = false

        // rigth
        dialogRightSample.backgroundColor = rightColor
        dialogRightSample.widthAnchor.constraint(equalToConstant: 117).isActive = true
        dialogRightSample.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dialogRightSample.layer.cornerRadius = 10
        dialogRightSample.trailingAnchor.constraint(equalTo: parentBtnView.trailingAnchor, constant: -27).isActive = true
        dialogRightSample.bottomAnchor.constraint(equalTo: parentBtnView.bottomAnchor, constant: -10).isActive = true

        dialogRightSample.isUserInteractionEnabled = false
    }
}

extension SettingsViewController {
    func setThemeButtonsStartState() {
        classicThemeBtn.layer.cornerRadius = 25
        classicThemeBtn.layer.borderWidth = 5
        classicThemeBtn.layer.borderColor = classicThemeBtn.backgroundColor?.cgColor
        dayThemeBtn.layer.cornerRadius = 25
        dayThemeBtn.layer.borderWidth = 5
        dayThemeBtn.layer.borderColor = dayThemeBtn.backgroundColor?.cgColor
        nightThemeBtn.layer.cornerRadius = 25
        nightThemeBtn.layer.borderWidth = 5
        nightThemeBtn.layer.borderColor = nightThemeBtn.backgroundColor?.cgColor

        switch UserDefaults.standard.object(forKey: "Theme") as? String {
        case "Classic":
            classicThemeBtn.isSelected = true
        case "Day":
            dayThemeBtn.isSelected = true
        case "Night":
            nightThemeBtn.isSelected = true
        case .none:
            break
        case .some:
            break
        }
    }
}

class UIButtonWithSelectBorder: UIButton {

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).cgColor
            } else {
                self.layer.borderColor = self.layer.backgroundColor
            }
        }
    }
}
