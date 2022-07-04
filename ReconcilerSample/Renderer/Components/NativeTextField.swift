import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeTextField: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let textField = UITextField()
        textField.yoga
            .width(.auto)
            .height(.auto)
            .flexGrow(1)
        update(textField, props: props, updatePayload: .all)
        return textField
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
        guard let textField = view as? UITextField else {
            return
        }
        updateText(textField, props: props, updatePayload: updatePayload)
        updatePlaceholder(textField, props: props, updatePayload: updatePayload)
        updateOnChange(textField, props: props, updatePayload: updatePayload)
    }

    private static func updateText(_ textField: UITextField, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("text") else {
            return
        }
        guard let text = props.getSafeString("text") else {
            return
        }
        textField.text = text
    }

    private static func updatePlaceholder(_ textField: UITextField, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("placeholder") else {
            return
        }
        guard let placeholder = props.getSafeString("placeholder") else {
            return
        }
        textField.placeholder = placeholder
    }

    private static func updateOnChange(_ textField: UITextField, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("onChange") else {
            return
        }
        guard let onChange = props.getSafeObject("onChange") else {
            return
        }
        textField.replaceAction(.init { _ in
            globalCurrentEvent = "textfield"
            onChange.call(withArguments: [textField.text ?? ""])
            globalCurrentEvent = ""
        }, for: .editingChanged)
    }
}
