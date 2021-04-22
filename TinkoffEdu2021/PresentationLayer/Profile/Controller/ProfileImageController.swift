//
//  ProfileImgConttoller.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 23.02.2021.
//

import Foundation
import UIKit

extension ProfileViewController {

    @objc func profileImgTap(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Select image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: chooseFromGallery(action:)))
        alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: takeCameraPhoto(action:)))
        alert.addAction(UIAlertAction(title: "Download", style: .default, handler: dowloadImage(action:)))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alert, animated: true)
    }

    func chooseFromGallery(action: UIAlertAction) {
        model.imagePicker.delegate = self
        model.imagePicker.mediaTypes = ["public.image"]
        model.imagePicker.sourceType = .photoLibrary
        present(model.imagePicker, animated: true, completion: nil)
    }

    func takeCameraPhoto(action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            model.imagePicker.delegate = self
            model.imagePicker.sourceType = .camera
            present(model.imagePicker, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                let style = UIAlertController.Style.alert
                let alert = UIAlertController(title: "Камера недоступна", message: "", preferredStyle: style)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func dowloadImage(action: UIAlertAction) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let next = storyBoard.instantiateViewController(withIdentifier: "ApiProfileCollectionViewController") as? ApiProfileCollectionViewController else {
            return
        }
        self.present(next, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            startEdit()
            profileImg?.image = image
            enableSaveBtn()
            model.state.isImgChanged = true
        }
    }
}
