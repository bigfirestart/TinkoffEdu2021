//
//  SettingsExtensions.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 09.03.2021.
//

import Foundation
import UIKit

extension SettingsViewController {
    func themePreviewBtnAddSubviews(parentBtnView: UIButton, leftColor: UIColor, rightColor: UIColor){
        let dialogLeftSample = UIView()
        let dialogRightSample = UIView()
        
        parentBtnView.addSubview(dialogLeftSample)
        parentBtnView.addSubview(dialogRightSample)
        
        dialogLeftSample.translatesAutoresizingMaskIntoConstraints = false
        dialogRightSample.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        dialogLeftSample.backgroundColor = leftColor
        dialogLeftSample.widthAnchor.constraint(equalToConstant: 117).isActive = true
        dialogLeftSample.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dialogLeftSample.layer.cornerRadius = 10
        dialogLeftSample.leadingAnchor.constraint(equalTo: parentBtnView.leadingAnchor, constant: 27).isActive = true
        dialogLeftSample.topAnchor.constraint(equalTo: parentBtnView.topAnchor, constant: 10).isActive = true
        
        //rigth
        dialogRightSample.backgroundColor = rightColor
        dialogRightSample.widthAnchor.constraint(equalToConstant: 117).isActive = true
        dialogRightSample.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dialogRightSample.layer.cornerRadius = 10
        dialogRightSample.trailingAnchor.constraint(equalTo: parentBtnView.trailingAnchor, constant: -27).isActive = true
        dialogRightSample.bottomAnchor.constraint(equalTo: parentBtnView.bottomAnchor, constant: -10).isActive = true
    }
}
