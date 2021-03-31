//
//  ProfileSaveOperation.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 18.03.2021.
//

import Foundation
import UIKit

class ProfileStorageAsyncOperation: Operation {
    var isReadOperation: Bool = false
    var profile: Profile
    var profileImg: UIImage?
    var profileVC: ProfileViewController

    override var isAsynchronous: Bool { true }

    init(profile: Profile, profileImg: UIImage?, profileVC: ProfileViewController) {
        self.profile = profile
        self.profileImg = profileImg
        self.profileVC = profileVC
    }

    override func start() {
        if isReadOperation {
            getProfile()
            getProfileImg()
        } else {
            saveProfile()
        }
    }
    func saveProfile() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let profileJson = profile.decode() ?? ""

        if let data = profileImg?.pngData() {
            if let path = documentDirectory?.appendingPathComponent("profile.png") {
                do {
                    try data.write(to: path)
                } catch {
                    OperationQueue.main.addOperation {
                        self.profileVC.faltureSaveAfter(errorText: error.localizedDescription, isGDC: false)
                    }
                }
            }
        }

        // saving json
        if let path = documentDirectory?.appendingPathComponent("profile.json") {
            do {
                try profileJson.write(to: path, atomically: true, encoding: .utf8)
            } catch {
                OperationQueue.main.addOperation {
                    self.profileVC.faltureSaveAfter(errorText: error.localizedDescription, isGDC: false)
                }
            }
        }
        OperationQueue.main.addOperation {
            self.profileVC.successSaveAfter()
        }
    }
    func getProfile() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let path = documentDirectory?.appendingPathComponent("profile.json") {
            do {
                let profileString = try String(contentsOf: path, encoding: .utf8)
                if let profile = Profile.endcode(jsonProfile: profileString) {
                    self.profile = profile
                }
            } catch {}
        }
    }
    func getProfileImg() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let path = documentDirectory?.appendingPathComponent("profile.png") {
            self.profileImg = UIImage(contentsOfFile: path.path)
        }
    }
}
