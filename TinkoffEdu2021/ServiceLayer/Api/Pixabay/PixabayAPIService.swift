//
//  PixabayAPIService.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation
import UIKit

class PixabayAPIService {
    static func getImageList(completionHandler: @escaping ([ImageListItem]?, String?) -> Void) {
        let requestConfig = RequestFactory.PixabayRequests.searchImages()
        
        RequestSender().send(config: requestConfig) { (result: Result<[ImageListItem], Error>) in
            switch result {
            case .success(let pictures):
                completionHandler(pictures, nil)
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    static func downloadImage(urlString: String,
                              completionHandler: @escaping (UIImage?, String?) -> Void) {
           let requestConfig = RequestFactory.PixabayRequests.downloadImage(urlString: urlString)
           
        RequestSender().send(config: requestConfig) { (result: Result<UIImage, Error>) in
               switch result {
               case .success(let picture):
                   completionHandler(picture, nil)
               case .failure(let error):
                completionHandler(nil, error.localizedDescription)
               }
           }
       }
}
