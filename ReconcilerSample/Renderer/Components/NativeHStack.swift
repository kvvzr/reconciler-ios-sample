import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeHStack: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let view = UIView()
        view.yoga
            .alignItems(.stretch)
            .justifyContent(.flexStart)
            .flexDirection(.row)

        update(view, props: props, updatePayload: .all)
        return view
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
    }
}
