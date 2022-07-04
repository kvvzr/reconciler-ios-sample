import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeToggle: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let uiSwitch = UISwitch()
        uiSwitch.yoga.width(.auto).height(.auto)
        update(uiSwitch, props: props, updatePayload: .all)
        return uiSwitch
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
        guard let uiSwitch = view as? UISwitch else {
            return
        }
        updateIsOn(uiSwitch, props: props, updatePayload: updatePayload)
        updateOnChange(uiSwitch, props: props, updatePayload: updatePayload)
    }

    private static func updateIsOn(_ uiSwitch: UISwitch, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("isOn") else {
            return
        }
        guard let isOn = props.getSafeBool("isOn") else {
            return
        }
        uiSwitch.isOn = isOn
    }

    private static func updateOnChange(_ uiSwitch: UISwitch, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("onChange") else {
            return
        }
        guard let onChange = props.getSafeObject("onChange") else {
            return
        }
        uiSwitch.replaceAction(.init { _ in
            globalCurrentEvent = "toggle"
            onChange.call(withArguments: [uiSwitch.isOn])
            globalCurrentEvent = ""
        }, for: .valueChanged)
    }
}
