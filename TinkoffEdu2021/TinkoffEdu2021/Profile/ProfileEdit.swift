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
        state.fioText = fioUITextField.text ?? ""
        state.aboutText = aboutUITextView.text ?? ""
        state.img = profileImg.image ?? UIImage()
    }

    func restoreSavedState() {
        fioUITextField.text = state.fioText
        aboutUITextView.text = state.aboutText
        profileImg.image = state.img

    }

    func stopEdit() {
        fioUITextField.isUserInteractionEnabled = false
        aboutUITextView.isUserInteractionEnabled = false
        profileEditBtn.setTitle("Edit", for: .normal)
        saveGCDBtn.isHidden = true
        saveOperationsBtn.isHidden = true
        isInEditMode = false
    }

    func startEdit() {
        saveState()
        fioUITextField.isUserInteractionEnabled = true
        aboutUITextView.isUserInteractionEnabled = true
        profileEditBtn.setTitle("Cancel", for: .normal)
        fioUITextField.becomeFirstResponder()
        saveGCDBtn.isHidden = false
        saveGCDBtn.isEnabled = false
        saveOperationsBtn.isHidden = false
        saveOperationsBtn.isEnabled = false
        isInEditMode = true
    }

    @objc func editButtonClick() {
        if isInEditMode {
            stopEdit()
            self.restoreSavedState()
        } else {
            startEdit()
        }

    }
    func profileControllerSavePrepare() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true

        saveGCDBtn.isEnabled = false
        saveOperationsBtn.isEnabled = false

        profileEditBtn.isEnabled = false
    }

    @objc func onGDCSaveClick() {
        profileControllerSavePrepare()
        saveGDC()
    }

    @objc func onOperationSaveClick() {
        profileControllerSavePrepare()
        saveOperations()
    }

    @objc func textFieldChanged() {
        saveGCDBtn.isEnabled = true
        saveOperationsBtn.isEnabled = true
    }
    @objc func enableSaveBtn() {
        saveGCDBtn.isEnabled = true
        saveOperationsBtn.isEnabled = true
    }

    func saveGDC() {
        let profile = Profile(name: fioUITextField.text ?? "", info: aboutUITextView.text ?? "")
        if let img = profileImg.image {
            saveProfileGDC(profile: profile, img: img)
        } else {
            saveProfileGDC(profile: profile, img: nil)
        }
    }

    func saveOperations() {
        let profile = Profile(name: fioUITextField.text ?? "", info: aboutUITextView.text ?? "")
        let queue = OperationQueue()
        let operation = ProfileStorageAsyncOperation(profile: profile, profileImg: nil, profileVC: self)
        if let img = profileImg.image {
            operation.profileImg = img
        }
        queue.addOperation(operation)
    }

    func successSaveAfter() {
        self.stopEdit()

        let alert = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        self.activityIndicator.stopAnimating()
        self.profileEditBtn.isEnabled = true
    }

    func faltureSaveAfter(errorText: String, isGDC: Bool) {
        let alert = UIAlertController(title: errorText, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        if isGDC {
            alert.addAction(UIAlertAction(title: "Повторить",
                                          style: UIAlertAction.Style.default,
                                          handler: {_ in self.saveGDC()}))
        } else {
            alert.addAction(UIAlertAction(title: "Повторить",
                                          style: UIAlertAction.Style.default,
                                          handler: {_ in self.saveOperations()}))
        }

        self.present(alert, animated: true, completion: nil)
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
