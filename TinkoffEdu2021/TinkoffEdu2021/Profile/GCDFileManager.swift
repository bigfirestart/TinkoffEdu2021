//
//  GCDFileManager.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 17.03.2021.
//

import Foundation
import UIKit



struct Profile: Codable {
    var name: String
    var info: String
}

func decodeProfile(profile: Profile) -> String?  {
    do {
        let jsonData = try JSONEncoder().encode(profile)
        return String(decoding: jsonData, as: UTF8.self)
    }
    catch{
        return nil
    }
   
}

func endcodeProfile(jsonProfile: String) -> Profile? {
    do {
        let jsonData = jsonProfile.data(using: .utf8) ?? Data()
        return try JSONDecoder().decode(Profile.self, from: jsonData)
    }
    catch{
        return nil
    }
}

class DataSavingManager {
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    static let profilePath = documentDirectory?.appendingPathComponent("profile.json")
    static let profileImgPath = documentDirectory?.appendingPathComponent("profile.png")
    
    static func saveProfile(profile: Profile) {
        let profileJson = decodeProfile(profile: profile) ?? ""
        if let path = profilePath {
            do {
                try profileJson.write(to: path, atomically: true, encoding: .utf8)
            }
            catch {
                
            }
        }
    }
    
    static func getProfile() -> Profile? {
        if let path = profilePath {
            do {
                let profileString = try String(contentsOf: path, encoding: .utf8)
                return endcodeProfile(jsonProfile: profileString)
            }
            catch {
                return nil
            }
        }
        return nil
    }
    
    static func saveProfileImg(image: UIImage) {
        let data = image.pngData()
        
        if let path = profileImgPath {
            do {
                try data?.write(to: path)
            }
            catch { }
        }
    }
    
    static func getProfileImg() -> UIImage? {
        if let path = profileImgPath {
            return UIImage(contentsOfFile: path.path)
        }
        return nil
    }
}

class GCDFileManager {
   
    
    
}
