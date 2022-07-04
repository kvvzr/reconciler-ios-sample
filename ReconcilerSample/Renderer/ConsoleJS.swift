import JavaScriptCore

@objc protocol ConsoleJS: JSExport {
    func _log(_ logLevel: String, _ args: JSValue) -> Void
}

class ConsoleJSImpl: NSObject, ConsoleJS {
    func _log(_ logLevel: String, _ args: JSValue) -> Void {
        #if DEBUG
        let prefix: String
        switch logLevel {
        case "verbose":
            prefix = "💜"
        case "debug":
            prefix = "💚"
        case "info":
            prefix = "💙"
        case "warning":
            prefix = "💛"
        case "error":
            prefix = "❤️"
        default:
            prefix = "💜"
        }
        print([prefix] + getLogMessage(args), separator: " ", terminator: "\n")
        #endif
    }

    private func getLogMessage(_ args: JSValue) -> [Any] {
        if args.isArray {
            let length = args.objectForKeyedSubscript("length").toInt32()
            return (0 ..< length).compactMap { index -> String? in
                guard let arg = args.objectAtIndexedSubscript(Int(index)) else {
                    return nil
                }
                let jsContext = JSContext()!
                jsContext.setObject(arg.toObject(), forKeyedSubscript: "obj" as NSString)
                let result = jsContext.evaluateScript("JSON.stringify(obj, null , \"\t\")")
                return result?.toString() ?? ""
            }
        } else {
            return [args.toString() ?? ""]
        }
    }
}
