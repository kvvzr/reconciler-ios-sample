import JavaScriptCore
import SwiftUI

public func createJSContext() -> JSContext {
    let context = JSContext()!
    context.exceptionHandler = { _, value in
        guard let value = value else {
            return
        }
        let line = value.objectForKeyedSubscript("line")!
        let stack = value.objectForKeyedSubscript("stack")!

        print("❤️", "message: \(value.description)")
        print("❤️", "line: \(line)")
        print("❤️", "stack: \(stack)")
    }

    setConsole(context)

    do {
        try loadCore(context)
    } catch {
        assertionFailure(error.localizedDescription)
    }

    return context
}

private func setConsole(_ context: JSContext) {
    context.setObject(ConsoleJSImpl(), forKeyedSubscript: "console" as NSString)
    context.evaluateScript("""
        console.log = function(...args) {
            console._log("verbose", args)
        }
        console.debug = function(...args) {
            console._log("debug", args)
        }
        console.info = function(...args) {
            console._log("info", args)
        }
        console.warn = function(...args) {
            console._log("warning", args)
        }
        console.error = function(...args) {
            console._log("error", args)
        }
        console.dir = function(...args) {
            console._log("verbose", args)
        }
    """)
}

private func loadCore(_ context: JSContext) throws {
    guard let path = Bundle.main.path(forResource: "main", ofType: "js") else {
        return
    }
    let url = URL(fileURLWithPath: path)
    let script = try String(contentsOf: url)
    context.evaluateScript(script)
}
