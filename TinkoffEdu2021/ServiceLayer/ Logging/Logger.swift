import Foundation

class Logger {

    public static func logOn() -> Bool {
        if let logOn = ProcessInfo.processInfo.environment["logOn"] {
            return logOn == "true"
        }
        return false
    }

    public static func info(message: String) {
        if logOn() {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            print(format.string(from: Date()) + " : " + message)
        }
    }

    public static func stateChangeLog(fromState: String, toState: String, methodName: String) {
        Logger.info(message: "Application moved from \(fromState) to \(toState): \(methodName)")
    }
}
