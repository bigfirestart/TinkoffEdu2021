import Foundation
import Firebase

struct Message {
    let identifier: String
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
}

func getChannelMessages(documentId: String, completion: @escaping(([Message]) -> Void)) {
    let reference = Firestore.firestore().collection("channels").document(documentId).collection("messages")

    reference.addSnapshotListener { snapshot, _ in
        var messages: [Message] = []
        if let documents = snapshot?.documents {
            for message in documents {
                let identifier = message.documentID
                let data = message.data()
                let content = data["content"] as? String ?? "..."
                let created = (data["created"] as? Timestamp)?.dateValue() ?? Date()
                let senderId = data["senderId"] as? String ?? ""
                let senderName = data["senderName"] as? String ?? "Unknown"
                
                messages.append(Message(identifier: identifier,
                                        content: content,
                                        created: created,
                                        senderId: senderId,
                                        senderName: senderName))
            }
        }
        messages = messages.sorted(by: {$0.created < $1.created })
        completion(messages)
    }

}

func addMessageToChannel(documentId: String, message: String) {
    let reference = Firestore.firestore().collection("channels").document(documentId).collection("messages")
    if let userId = UserDefaults.standard.object(forKey: "UserApiId") {
        reference.addDocument(data: ["content": message,
                                     "created": Date(),
                                     "senderName": "bigfirestart",
                                     "senderId": userId])
    }

}
