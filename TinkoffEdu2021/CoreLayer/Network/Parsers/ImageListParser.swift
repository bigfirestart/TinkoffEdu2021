//
//  ImageListParser.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation

struct ImageListItem: Codable {
    let previewURL: String
    let largeImageURL: String
}

struct ImageList: Codable {
    let hits: [ImageListItem]
}

class ImageListParser: IParser {
    typealias Model = [ImageListItem]
    
    func parse(data: Data) -> Model? {
        do {
            return try JSONDecoder().decode(ImageList.self, from: data).hits
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
}
