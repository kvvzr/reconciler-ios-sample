import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeText: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let label = UILabel()
        label.font.withSize(14.0)
        label.yoga.width(.auto).height(.auto)
        update(label, props: props, updatePayload: .all)
        return label
    }

    static func create(_ text: String) -> UIView {
        let label = UILabel()
        label.font.withSize(14.0)
        label.yoga.width(.auto).height(.auto)
        update(label, text: text)
        return label
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
        guard let label = view as? UILabel else {
            return
        }
        updateChildren(label, props: props, updatePayload: updatePayload)
        updateStrike(label, props: props, updatePayload: updatePayload)
    }

    static func update(_ view: UIView, text: String) {
        guard let label = view as? UILabel else {
            return
        }
        updateText(label, text: text)
    }

    private static func updateChildren(_ label: UILabel, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("children") else {
            return
        }
        guard let text = props.getSafeString("children") else {
            return
        }
        updateText(label, text: text)
    }

    private static func updateText(_ label: UILabel, text: String) {
        label.text = text
        label.yoga.markDirty()
    }

    private static func updateStrike(_ label: UILabel, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("strike") else {
            return
        }
        guard let strike = props.getSafeBool("strike") else {
            return
        }
        let text = label.text
        if strike {
            let attributeString = NSMutableAttributedString(string: label.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            label.attributedText = attributeString
        } else {
            label.attributedText = nil
            label.text = text
        }
    }
}
