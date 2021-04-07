//
//  FirebaseChannel.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 24.03.2021.
//

import Foundation
import Firebase

struct Channel {
    let identifier: String
    let name: String
    let lastMessage: String?
    let lastActivity: Date?
}

func getChannels(completion: @escaping(([Channel]) -> Void)) {
    let reference = Firestore.firestore().collection("channels")

    reference.addSnapshotListener { snapshot, _ in
        var channels: [Channel] = []
        if let documents = snapshot?.documents {
            for document in documents {
                let data = document.data()

                let identifier = document.documentID
                let name = data["name"] as? String ?? "Sample Name"
                let lastMessage = data["lastMessage"] as? String
                let lastActivity = (data["lastActivity"] as? Timestamp)?.dateValue()
                let channel = Channel(identifier: identifier,
                                      name: name,
                                      lastMessage: lastMessage,
                                      lastActivity: lastActivity)
                channels.append(channel)
            }
        }
        if let oldDate = Calendar.current.date(byAdding: .year, value: -18, to: Date()) {
            channels = channels.sorted(by: {$0.lastActivity ?? oldDate > $1.lastActivity ?? oldDate})
        }
        completion(channels)
    }

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
