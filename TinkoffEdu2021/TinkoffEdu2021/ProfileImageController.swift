//
//  ProfileImgConttoller.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 23.02.2021.
//

import Foundation
import UIKit


extension ViewController {
    
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
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takeCameraPhoto(action: UIAlertAction){
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImg.image = image
        profileSymbolsLabel.isHidden = true
        
    }
}
