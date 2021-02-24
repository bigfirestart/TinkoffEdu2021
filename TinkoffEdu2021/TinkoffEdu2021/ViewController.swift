//
//  ViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit
import Foundation


class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var profileImg: UIImageView?
    @IBOutlet weak var profileEditBtn: UIButton?
    @IBOutlet weak var profileSymbolsLabel: UILabel?
    
    var imagePicker = UIImagePickerController()
    let logger = Logger()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // тут view ещё не загружен
        logger.info(message: "init frame - \(getProfileEditBtnFrame())")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // тут view из сториборда
        logger.info(message: "viewDidLoad frame - \(getProfileEditBtnFrame())")
        
        profileImg?.layer.cornerRadius = (profileImg?.frame.height ?? 1)/2
        profileEditBtn?.layer.cornerRadius = 14
        
        profileImg?.isUserInteractionEnabled = true
        let profileImgGesture = UITapGestureRecognizer(target: self, action: #selector(profileImgTap(_:)))
        profileImg?.addGestureRecognizer(profileImgGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // тут view перерисовался под наше устройство, поэтому отличается
        logger.info(message: "viewDidAppear frame - \(getProfileEditBtnFrame())")
    }

}

