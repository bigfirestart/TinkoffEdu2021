//
//  SettingsViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 09.03.2021.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var classicThemeBtn: UIButtonWithSelectBorder!
    @IBOutlet weak var dayThemeBtn: UIButtonWithSelectBorder!
    @IBOutlet weak var nightThemeBtn: UIButtonWithSelectBorder!
    @IBOutlet weak var classicThemeLabel: UILabel!
    @IBOutlet weak var dayThemeLabel: UILabel!
    @IBOutlet weak var nightThemeLabel: UILabel!

    // может возникнуть retain cycle если themeDelegate будет ссылаться на SettingsViewController
    weak var themeDelegate: ThemesPickerDelegate?

    // может возникнуть цикл если будем использовать self
    // var themeHandler: ((Theme) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        setThemeButtonsStartState()

        // swiftlint:disable:next line_length
        themePreviewBtnAddSubviews(parentBtnView: classicThemeBtn, leftColor: UIColor(red: 233 / 255, green: 233 / 255, blue: 233 / 255, alpha: 1), rightColor: UIColor(red: 220 / 255, green: 247 / 255, blue: 197 / 255, alpha: 1))
        // swiftlint:disable:next line_length
        themePreviewBtnAddSubviews(parentBtnView: dayThemeBtn, leftColor: UIColor(red: 234 / 255, green: 235 / 255, blue: 237 / 255, alpha: 1), rightColor: UIColor(red: 67 / 255, green: 137 / 255, blue: 249 / 255, alpha: 1))
        // swiftlint:disable:next line_length
        themePreviewBtnAddSubviews(parentBtnView: nightThemeBtn, leftColor: UIColor(red: 92 / 255, green: 92 / 255, blue: 92 / 255, alpha: 1), rightColor: UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1))

        classicThemeBtn.addTarget(self, action: #selector(classicThemeTap(_ :)), for: .touchUpInside)
        let classicTap = UITapGestureRecognizer(target: self, action: #selector(classicThemeTap(_ :)))
        classicThemeLabel.isUserInteractionEnabled = true
        classicThemeLabel.addGestureRecognizer(classicTap)

        dayThemeBtn.addTarget(self, action: #selector(dayThemeTap(_ :)), for: .touchUpInside)
        let dayTap = UITapGestureRecognizer(target: self, action: #selector(dayThemeTap(_ :)))
        dayThemeLabel.isUserInteractionEnabled = true
        dayThemeLabel.addGestureRecognizer(dayTap)

        nightThemeBtn.addTarget(self, action: #selector(nightThemeTap(_ :)), for: .touchUpInside)
        let nightTap = UITapGestureRecognizer(target: self, action: #selector(nightThemeTap(_ :)))
        nightThemeLabel.isUserInteractionEnabled = true
        nightThemeLabel.addGestureRecognizer(nightTap)
    }

    @objc func classicThemeTap(_ sender: UITapGestureRecognizer) {
        classicThemeBtn.isSelected = true
        dayThemeBtn.isSelected = false
        nightThemeBtn.isSelected = false

        themeDelegate?.didChangeTheme(.classic)
        // themeHandler?(.classic)
        UserDefaults.standard.setValue("Classic", forKey: "Theme")
    }
    @objc func dayThemeTap(_ sender: UITapGestureRecognizer) {
        classicThemeBtn.isSelected = false
        dayThemeBtn.isSelected = true
        nightThemeBtn.isSelected = false
        themeDelegate?.didChangeTheme(.day)
        // themeHandler?(.day)
        UserDefaults.standard.setValue("Day", forKey: "Theme")
    }
    @objc func nightThemeTap(_ sender: UITapGestureRecognizer) {
        classicThemeBtn.isSelected = false
        dayThemeBtn.isSelected = false
        nightThemeBtn.isSelected = true
        themeDelegate?.didChangeTheme(.night)
        // themeHandler?(.night)
        UserDefaults.standard.setValue("Night", forKey: "Theme")
    }
}
