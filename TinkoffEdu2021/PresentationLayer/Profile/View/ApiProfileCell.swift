//
//  ApiProfileCell.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation
import UIKit

class ApiProfileCell: UICollectionViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure() {
        self.activityIndicator.isHidden = false
        self.contentView.backgroundColor = .gray
        self.activityIndicator.startAnimating()
    }
    
    func setImage(image: UIImage) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.contentView.backgroundColor = UIColor(patternImage: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.backgroundColor = .gray
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }

}
