//
//  ProfileImgConttoller.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 23.02.2021.
//

import Foundation
import UIKit


extension ProfileViewController {
    
    @objc func profileImgTap(_ sender: UITapGestureRecognizer){
        let ac = UIAlertController(title: "Select image", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: chooseFromGallery(action:)))
        ac.addAction(UIAlertAction(title: "Take photo", style: .default, handler: takeCameraPhoto(action:)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    
    func chooseFromGallery(action: UIAlertAction){
        imagePicker.delegate = self
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takeCameraPhoto(action: UIAlertAction){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        else{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Камера недоступна", message: "",  preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            startEdit()
            profileImg?.image = image
            enableSaveBtn()
            state.isImgChanged = true
        }
    }
}
