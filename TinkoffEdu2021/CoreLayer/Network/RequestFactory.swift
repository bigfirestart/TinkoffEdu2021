//
//  RequestFactory.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation

struct RequestFactory {
    
    struct PixabayRequests {
        
        private static let apiKey = "21269507-831cedab8dfcf6db8da4bebee"
        
        static func searchImages() -> RequestConfig<ImageListParser> {
            let request = ImageListRequest(key: apiKey)
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
