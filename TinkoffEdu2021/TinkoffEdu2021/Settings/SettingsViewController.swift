//
//  SettingsViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 09.03.2021.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var classicThemeBtn: UIButton!
    @IBOutlet weak var dayThemeBtn: UIButton!
    @IBOutlet weak var nigthThemeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classicThemeBtn.layer.cornerRadius = 25
        dayThemeBtn.layer.cornerRadius = 25
        nigthThemeBtn.layer.cornerRadius = 25
        
        themePreviewBtnAddSubviews(parentBtnView: classicThemeBtn, leftColor: AppColors.classicGray, rightColor: AppColors.classicGreen)
        themePreviewBtnAddSubviews(parentBtnView: dayThemeBtn, leftColor: AppColors.dayWhite, rightColor: AppColors.dayBlue)
        themePreviewBtnAddSubviews(parentBtnView: nigthThemeBtn, leftColor: AppColors.nigthBlack, rightColor: AppColors.nigthGray)
     
    }
}

