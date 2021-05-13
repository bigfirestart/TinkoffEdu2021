//
//  RequestFactory.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation

struct RequestFactory {
    
    struct PixabayRequests {
        
        private static let apiKey = Bundle.main.object(forInfoDictionaryKey: "PIXABAY_API_KEY")
        
        static func searchImages() -> RequestConfig<ImageListParser> {
            print(apiKey)
            guard let key = apiKey as? String else { preconditionFailure() }
            let request = ImageListRequest(key: key)
            let parser = ImageListParser()
            
            return RequestConfig<ImageListParser>(request: request, parser: parser)
        }
        
        static func downloadImage(urlString: String) -> RequestConfig<DownloadImageParser> {
            let request = DownloadImageRequest(urlString: urlString)
            let parser = DownloadImageParser()
            
            return RequestConfig<DownloadImageParser>(request: request, parser: parser)
        }
    }
    
}
