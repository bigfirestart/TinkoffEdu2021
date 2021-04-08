//
//  FirebaseChannel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 24.03.2021.
//

import Foundation
import Firebase
import CoreData

struct Channel {
    let identifier: String
    let name: String
    let lastMessage: String?
    let lastActivity: Date?
}

func createChannel(channelName: String) {
    if channelName != "" {
        let reference = Firestore.firestore().collection("channels")
        reference.addDocument(data: ["name": channelName, "lastActivity": Date()])
    }
}

func deleteChannel(id: String) {
    let reference = Firestore.firestore().collection("channels")
    reference.document(id).delete()
}
