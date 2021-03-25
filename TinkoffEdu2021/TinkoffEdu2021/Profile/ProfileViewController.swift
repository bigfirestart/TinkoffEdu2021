//
//  ViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate , UITextViewDelegate,  UINavigationControllerDelegate {
    @IBOutlet weak var cancelModalLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileEditBtn: UIButton!
    @IBOutlet weak var saveGCDBtn: UIButton!
    @IBOutlet weak var saveOperationsBtn: UIButton!
    
    @IBOutlet weak var aboutUITextView: UITextView!
    @IBOutlet weak var fioUITextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imagePicker = UIImagePickerController()
    var isInEditMode = false
    var state = ProfileViewControllerState(fioText: "", aboutText: "", img: UIImage(), isImgChanged: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg?.layer.cornerRadius = (profileImg?.frame.height ?? 1)/2
        profileEditBtn?.layer.cornerRadius = 14
        
        profileImg?.isUserInteractionEnabled = true
        let profileImgGesture = UITapGestureRecognizer(target: self, action: #selector(profileImgTap(_:)))
        profileImg?.addGestureRecognizer(profileImgGesture)
        
        activityIndicator.isHidden = true
    
        
        // buttons and textfields
        saveGCDBtn.layer.cornerRadius = 14
        saveGCDBtn.isHidden = true
        saveOperationsBtn.layer.cornerRadius = 14
        saveOperationsBtn.isHidden = true
        
        fioUITextField.isUserInteractionEnabled = false
        aboutUITextView.isUserInteractionEnabled = false
        profileEditBtn.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        saveGCDBtn.addTarget(self, action: #selector(onGDCSaveClick), for: .touchUpInside)
        saveOperationsBtn.addTarget(self, action: #selector(onOperationSaveClick), for: .touchUpInside)
        fioUITextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        aboutUITextView.delegate = self
        
        getProfileGDC()
        
        isInEditMode = false
        self.hideKeyboardWhenTappedAround()
        
        
        cancelModalLabel.isUserInteractionEnabled = true
        cancelModalLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(closeModal)))
    }
    
    @objc func closeModal(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textFieldChanged()
    }
    
    func setProfile(resProfile: Profile?, resImg: UIImage?){
        fioUITextField.text = resProfile?.name
        aboutUITextView.text = resProfile?.info

        if let img = resImg {
            profileImg.image = img
        }
    }
}
class ProfileUILabel: UILabel {}
