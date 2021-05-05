//
//  PixabayAPIServiceProtocol.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 05.05.2021.
//

import Foundation
import UIKit

protocol PixabayAPIServiceProtocol {
    init(requestSender: IRequestSender)
    func getImageList(completionHandler: @escaping ([ImageListItem]?, Error?) -> Void)
    func downloadImage(urlString: String, completionHandler: @escaping (UIImage?, Error?) -> Void)
}
