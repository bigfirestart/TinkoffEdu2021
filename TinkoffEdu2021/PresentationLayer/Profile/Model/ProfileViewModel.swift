//
//  ProfileModel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 15.04.2021.
//

import Foundation
import UIKit

struct ProfileViewModel {
    var imagePicker = UIImagePickerController()
    var isInEditMode = false
    var state = ProfileViewControllerState(fioText: "", aboutText: "", img: UIImage(), isImgChanged: false)
}
