//
//  ViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit
import Foundation


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var cancelModalLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileEditBtn: UIButton!
    @IBOutlet weak var saveGCDBtn: UIButton!
    @IBOutlet weak var saveOperationsBtn: UIButton!
    @IBOutlet weak var aboutUITextField: UITextField!
    @IBOutlet weak var fioUITextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imagePicker = UIImagePickerController()
    var isInEditMode = false
    var savedState = ProfileViewControllerState(fioText: "", aboutText: "", img: UIImage(), isImgChanged: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg?.layer.cornerRadius = (profileImg?.frame.height ?? 1)/2
        profileEditBtn?.layer.cornerRadius = 14
        
        profileImg?.isUserInteractionEnabled = true
        let profileImgGesture = UITapGestureRecognizer(target: self, action: #selector(profileImgTap(_:)))
        profileImg?.addGestureRecognizer(profileImgGesture)
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        // buttons and textfields
        saveGCDBtn.layer.cornerRadius = 14
        saveGCDBtn.isHidden = true
        saveOperationsBtn.layer.cornerRadius = 14
        saveOperationsBtn.isHidden = true
        
        fioUITextField.isUserInteractionEnabled = false
        aboutUITextField.isUserInteractionEnabled = false
        profileEditBtn.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        saveGCDBtn.addTarget(self, action: #selector(onSaveClick), for: .touchUpInside)
        fioUITextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        aboutUITextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        isInEditMode = false
        self.hideKeyboardWhenTappedAround()
        
        //getting data
        if let profile = DataSavingManager.getProfile(){
            fioUITextField.text = profile.name
            aboutUITextField.text = profile.info
        }
        
        if let img = DataSavingManager.getProfileImg() {
            profileImg.image = img
        }
        
        
        cancelModalLabel.isUserInteractionEnabled = true
        cancelModalLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(closeModal)))
    }
    
    @objc func closeModal(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
class ProfileUILabel: UILabel {}
