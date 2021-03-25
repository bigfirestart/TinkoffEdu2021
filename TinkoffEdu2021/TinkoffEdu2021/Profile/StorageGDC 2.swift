//
//  StorageGDC.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 18.03.2021.
//

import Foundation
import UIKit

extension ProfileViewController {
    func saveProfileGDC(profile: Profile, img: UIImage?) {
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
                            self.faltureSaveAfter(errorText: error.localizedDescription, isGDC: true)
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
                self.successSaveAfter()
            }
        }
    }

    func getProfileGDC() {
        DispatchQueue.global().async {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            var profile: Profile?

            if let path = documentDirectory?.appendingPathComponent("profile.json") {
                do {
                    let profileString = try String(contentsOf: path, encoding: .utf8)
                    profile=Profile.endcode(jsonProfile: profileString)
                } catch {
                    profile = nil
                }
            }

            var profileImg: UIImage?

            if let path = documentDirectory?.appendingPathComponent("profile.png") {
                profileImg = UIImage(contentsOfFile: path.path)
            }

            DispatchQueue.main.async {
                self.setProfile(resProfile: profile, resImg: profileImg)
            }
        }
    }
}
