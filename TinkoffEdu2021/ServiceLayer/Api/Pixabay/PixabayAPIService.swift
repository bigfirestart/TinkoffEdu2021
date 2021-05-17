//
//  PixabayAPIService.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation
import UIKit

class PixabayAPIService {
    private var requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func getImageList(completionHandler: @escaping ([ImageListItem]?, Error?) -> Void) {
        let requestConfig = RequestFactory.PixabayRequests.searchImages()
        
        requestSender.send(config: requestConfig) { (result: Result<[ImageListItem], Error>) in
            switch result {
            case .success(let pictures):
                completionHandler(pictures, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    func downloadImage(urlString: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let requestConfig = RequestFactory.PixabayRequests.downloadImage(urlString: urlString)
        requestSender.send(config: requestConfig) { (result: Result<UIImage, Error>) in
            switch result {
            case .success(let picture):
                completionHandler(picture, nil)
            case .failure(let error):
            completionHandler(nil, error)
            }
           }
       }
}
