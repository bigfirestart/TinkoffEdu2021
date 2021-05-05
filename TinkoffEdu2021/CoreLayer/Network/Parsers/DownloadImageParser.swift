//
//  DownloadImageParser.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation
import UIKit

class DownloadImageParser: IParser {
    typealias Model = UIImage
    
    func parse(data: Data) -> Model? {
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
}
