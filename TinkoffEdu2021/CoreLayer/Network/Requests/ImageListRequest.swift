//
//  ImageListRequest.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation

class ImageListRequest: IRequest {
    private let key: String
    private let domain = Bundle.main.object(forInfoDictionaryKey: "PIXABAY_SERVER_DOMAIN") as? String ?? ""
       
    private var parameters = ["q": "nature",
                              "image_type": "photo",
                              "pretty": "true",
                              "per_page": "200"]
       
    private var url: String {
        parameters["key"] = key
           
        var formingString = String()
        for pair in parameters {
            formingString.append("\(pair.key)=\(pair.value)&")
        }
        return String("\(domain)?\(formingString.dropLast())")
    }
       
   var urlRequest: URLRequest? {
       guard let url = URL(string: url) else { return nil }
       return URLRequest(url: url)
   }
   
   init(key: String) {
       self.key = key
   }
}
