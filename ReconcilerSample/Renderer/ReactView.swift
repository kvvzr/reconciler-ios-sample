import Combine
import JavaScriptCore
import SwiftUI
import SwiftYogaKit

public struct ReactView: UIViewRepresentable {
    private let jsFileName: String
    private let hostConfig = HostConfigImpl()
    private let jsContext: JSContext = createJSContext()

    public init(
        with jsFileName: String
    ) {
        self.jsFileName = jsFileName
    }

    public func makeUIView(context: Context) -> UIView {
        let uiView = UIView()
        uiView.yoga
            .width(.percent(100))
            .height(.percent(100))
            .alignItems(.stretch)
            .justifyContent(.flexStart)

        hostConfig.rootView = uiView

        try? setup()

        return uiView
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}

    private func setup() throws {
        guard let path = Bundle.main.path(forResource: jsFileName, ofType: "js") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        let script = try String(contentsOf: url)
        _ = jsContext.evaluateScript(script)

        jsContext.setObject(hostConfig, forKeyedSubscript: "HostConfigSwift" as NSString)
        _ = jsContext.evaluateScript("render()")!
    }
}
