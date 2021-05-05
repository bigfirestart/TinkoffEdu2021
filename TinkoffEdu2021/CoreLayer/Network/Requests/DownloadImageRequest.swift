//
//  DownloadImageRequest.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation

class DownloadImageRequest: IRequest {
    
    var urlString: String
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
}
