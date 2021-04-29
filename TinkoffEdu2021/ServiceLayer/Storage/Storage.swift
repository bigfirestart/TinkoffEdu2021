//
//  Storage.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 15.04.2021.
//

import Foundation
import UIKit

class GDCStorage {
    static func saveProfileGDC(profile: Profile,
                               img: UIImage?,
                               onComplete: @escaping (Error?) -> Void) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let profileJson = profile.decode() ?? ""
        DispatchQueue.global().async {
            // sleep(1)

            // saving img
            if let data = img?.pngData() {
                if let path = documentDirectory?.appendingPathComponent("profile.png") {
                    do {
                        try data.write(to: path)
                    } catch {
                        DispatchQueue.main.async {
                            onComplete(error)
                        }
                    }
                }
            }

            // saving json
            if let path = documentDirectory?.appendingPathComponent("profile.json") {
                do {
                    try profileJson.write(to: path, atomically: true, encoding: .utf8)
                } catch {

                }
            }
            DispatchQueue.main.async {
                onComplete(nil)
            }
        }
    }

    static func getProfileGDC( onComplete: @escaping (Profile?, UIImage?) -> Void ) {
        DispatchQueue.global().async {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            var profile: Profile?

            if let path = documentDirectory?.appendingPathComponent("profile.json") {
                do {
                    let profileString = try String(contentsOf: path, encoding: .utf8)
                    profile = Profile.endcode(jsonProfile: profileString)
                } catch {
                    profile = nil
                }
            }

            var profileImg: UIImage?

            if let path = documentDirectory?.appendingPathComponent("profile.png") {
                profileImg = UIImage(contentsOfFile: path.path)
            }

            DispatchQueue.main.async {
                onComplete(profile, profileImg)
            }
        }
    }
}
