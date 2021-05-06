//
//  ProfileEdit.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 17.03.2021.
//

import Foundation
import UIKit

extension ProfileViewController {
    func saveState() {
        model.state.fioText = fioUITextField.text ?? ""
        model.state.aboutText = aboutUITextView.text ?? ""
        model.state.img = profileImg.image ?? UIImage()
    }

    func restoreSavedState() {
        fioUITextField.text = model.state.fioText
        aboutUITextView.text = model.state.aboutText
        profileImg.image = model.state.img
    }

    func stopEdit() {
        fioUITextField.isUserInteractionEnabled = false
        aboutUITextView.isUserInteractionEnabled = false
        profileEditBtn.setTitle("Edit", for: .normal)
        saveGCDBtn.isHidden = true
        model.isInEditMode = false
        saveGCDBtn.layer.removeAllAnimations()
    }

    func startEdit() {
        saveState()
        fioUITextField.isUserInteractionEnabled = true
        aboutUITextView.isUserInteractionEnabled = true
        profileEditBtn.setTitle("Cancel", for: .normal)
        fioUITextField.becomeFirstResponder()
        saveGCDBtn.isHidden = false
        saveGCDBtn.isEnabled = false
        model.isInEditMode = true
        saveGCDBtn.shake()
    }
    
    @objc func editButtonClick() {
        if model.isInEditMode {
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
        profileEditBtn.isEnabled = false
    }

    @objc func onGDCSaveClick() {
        profileControllerSavePrepare()
        saveGDC()
    }

    @objc func textFieldChanged() {
        enableSaveBtn()
    }
    @objc func enableSaveBtn() {
        saveGCDBtn.isEnabled = true
        saveGCDBtn.stopShake()
    }

    func saveGDC() {
        let profile = Profile(name: fioUITextField.text ?? "", info: aboutUITextView.text ?? "")
        GDCStorage.saveProfileGDC(profile: profile, img: profileImg.image,
                                  onComplete: { error in
            if let err = error {
                self.faltureSaveAfter(errorText: err.localizedDescription)
            } else {
                self.successSaveAfter()
            }
        })
    }

    func successSaveAfter() {
        self.stopEdit()
        let style = UIAlertController.Style.alert
        let alert = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: style)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        self.activityIndicator.stopAnimating()
        self.profileEditBtn.isEnabled = true
    }

    func faltureSaveAfter(errorText: String) {
        let alert = UIAlertController(title: errorText, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Повторить",
                                      style: UIAlertAction.Style.default,
                                      handler: {_ in self.saveGDC()}))

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
