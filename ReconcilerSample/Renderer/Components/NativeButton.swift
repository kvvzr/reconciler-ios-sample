import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeButton: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.yoga.width(.auto).height(.auto)

        update(button, props: props, updatePayload: .all)
        return button
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
        guard let button = view as? UIButton else {
            return
        }
        updateTitle(button, props: props, updatePayload: updatePayload)
        updateOnClick(button, props: props, updatePayload: updatePayload)
    }

    private static func updateTitle(_ button: UIButton, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("title") else {
            return
        }
        guard let title = props.getSafeString("title") else {
            return
        }
        button.configuration?.title = title
    }

    private static func updateOnClick(_ button: UIButton, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("onClick") else {
            return
        }
        guard let onClick = props.getSafeObject("onClick") else {
            return
        }
        button.replaceAction(.init { _ in
            globalCurrentEvent = "button"
            onClick.call(withArguments: [])
            globalCurrentEvent = ""
        }, for: .touchUpInside)
    }
}
