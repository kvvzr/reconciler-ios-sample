import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeSlider: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let slider = UISlider()
        slider.yoga
            .width(.auto)
            .height(.auto)

        update(slider, props: props, updatePayload: .all)

        return slider
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
        guard let slider = view as? UISlider else {
            return
        }
        updateMax(slider, props: props, updatePayload: updatePayload)
        updateMin(slider, props: props, updatePayload: updatePayload)
        updateValue(slider, props: props, updatePayload: updatePayload)
        updateOnChange(slider, props: props, updatePayload: updatePayload)
    }

    private static func updateMax(_ slider: UISlider, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("max") else {
            return
        }
        guard let maxValue = props.getSafeDouble("max") else {
            return
        }
        slider.maximumValue = Float(maxValue)
    }

    private static func updateMin(_ slider: UISlider, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("min") else {
            return
        }
        guard let minValue = props.getSafeDouble("min") else {
            return
        }
        slider.minimumValue = Float(minValue)
    }

    private static func updateValue(_ slider: UISlider, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("value") else {
            return
        }
        guard let value = props.getSafeDouble("value") else {
            return
        }
        slider.value = Float(value)
    }

    private static func updateOnChange(_ slider: UISlider, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("onChange") else {
            return
        }
        guard let onChange = props.getSafeObject("onChange") else {
            return
        }
        slider.replaceAction(.init { _ in
            globalCurrentEvent = "slider"
            onChange.call(withArguments: [slider.value])
            globalCurrentEvent = ""
        }, for: .valueChanged)
    }
}
