//
//  ProfileInfo.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 18.03.2021.
//

import Foundation

class Profile: Codable {
    var name: String
    var info: String

    init(name: String, info: String) {
        self.name = name
        self.info = info
    }

    func decode() -> String? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return String(decoding: jsonData, as: UTF8.self)
        } catch {
            return nil
        }

    }

    static func endcode(jsonProfile: String) -> Profile? {
        do {
            let jsonData = jsonProfile.data(using: .utf8) ?? Data()
            return try JSONDecoder().decode(Profile.self, from: jsonData)
        } catch {
            return nil
        }

    }
}
