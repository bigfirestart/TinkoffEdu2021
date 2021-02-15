import Foundation

class Logger{
    public var logOn: Bool
    
    init() {
        self.logOn = true
    }
    
    init(logOn: Bool) {
        self.logOn = logOn
    }
    
    public func info(message: String) {
        if logOn {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            print(format.string(from: Date())  + " : " + message)
        }
    }
    
    public func stateChangeLog(fromState: String, toState: String, methodName: String) {
        self.info(message: "Application moved from \(fromState) to \(toState): \(methodName)")
    }
}

