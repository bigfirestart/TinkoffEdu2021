//
//  ViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileEditBtn: UIButton!
    @IBOutlet weak var profileSymbolsLabel: UILabel!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileEditBtn.layer.cornerRadius = 14
        
        profileImg.isUserInteractionEnabled = true
        let profileImgGesture = UITapGestureRecognizer(target: self, action: #selector(profileImgTap(_:)))
        profileImg.addGestureRecognizer(profileImgGesture)
    }
}

