//
//  ProfileEdit.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 17.03.2021.
//

import Foundation
import UIKit

struct ProfileViewControllerState {
    var fioText: String
    var aboutText: String
    var img: UIImage
    var isImgChanged: Bool
}

extension ProfileViewController {
    func saveState() {
        savedState.fioText = fioUITextField.text ?? ""
        savedState.aboutText = aboutUITextField.text ?? ""
        savedState.img = profileImg.image ?? UIImage()
    }
    
    func restoreSavedState() {
        fioUITextField.text = savedState.fioText
        aboutUITextField.text = savedState.aboutText
        profileImg.image = savedState.img
    }
    
    func stopEdit() {
        fioUITextField.isUserInteractionEnabled = false
        aboutUITextField.isUserInteractionEnabled = false
        profileEditBtn.setTitle("Edit", for: .normal)
        saveGCDBtn.isHidden = true
        saveOperationsBtn.isHidden = true
        isInEditMode = false
    }
    func startEdit() {
        saveState()
        fioUITextField.isUserInteractionEnabled = true
        aboutUITextField.isUserInteractionEnabled = true
        profileEditBtn.setTitle("Cancel", for: .normal)
        fioUITextField.becomeFirstResponder()
        saveGCDBtn.isHidden = false
        saveGCDBtn.isEnabled = false
        saveOperationsBtn.isHidden = false
        saveOperationsBtn.isEnabled = false
        isInEditMode = true
    }
    
    @objc func editButtonClick(){
        if isInEditMode {
            stopEdit()
            restoreSavedState()
        }
        else {
            startEdit()
        }
        
    }
    
    @objc func onSaveClick() {
        //saving here
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let profile = Profile(name: fioUITextField.text ?? "", info: aboutUITextField.text ?? "")
        DataSavingManager.saveProfile(profile: profile)
        
        if let img = profileImg.image {
            if savedState.isImgChanged{
                DataSavingManager.saveProfileImg(image: img)
            }
        }
    
        self.stopEdit()
        self.activityIndicator.stopAnimating()
        
    }
    
    @objc func textFieldChanged() {
        saveGCDBtn.isEnabled = true
        saveOperationsBtn.isEnabled = true
    }
    @objc func enableSaveBtn() {
        saveGCDBtn.isEnabled = true
        saveOperationsBtn.isEnabled = true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
