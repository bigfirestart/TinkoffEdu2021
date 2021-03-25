import Foundation
import Firebase


struct Message {
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
}


func getChannelMessages(documentId: String, completion: @escaping(([Message]) -> Void)) {
    let reference =  Firestore.firestore().collection("channels").document(documentId).collection("messages")

    reference.addSnapshotListener { snapshot, error in
        var messages: [Message] = []
        if let documents = snapshot?.documents{
            for message in documents{
                let data = message.data()
                let content = data["content"] as? String
                let created = (data["created"] as? Timestamp)?.dateValue()
                let senderId = data["senderId"] as? String
                let senderName = data["senderName"] as? String
                
                messages.append(Message(content: content ?? "...", created: created ?? Date(), senderId: senderId ?? "", senderName: senderName ?? "Unknown"))
            }
        }
        messages = messages.sorted(by: {$0.created < $1.created })
        completion(messages)
    }
    
}

func addMessageToChannel(documentId: String, message: String){
    let reference =  Firestore.firestore().collection("channels").document(documentId).collection("messages")
    if let userId = UserDefaults.standard.object(forKey: "UserApiId") {
        reference.addDocument(data: ["content": message,
                                     "created": Date(),
                                     "senderName": "bigfirestart",
                                     "senderId": userId])
    }
    
}
