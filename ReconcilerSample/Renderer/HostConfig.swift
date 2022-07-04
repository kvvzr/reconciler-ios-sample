import JavaScriptCore
import SwiftYogaKit
import UIKit

private let components: [String: NativeComponent.Type] = [
    "vstack": NativeVStack.self,
    "hstack": NativeHStack.self,
    "button": NativeButton.self,
    "text": NativeText.self,
    "slider": NativeSlider.self,
    "scroll": NativeScroll.self,
    "textfield": NativeTextField.self,
    "toggle": NativeToggle.self,
    "segmentedcontrol": NativeSegmentedControl.self
]

public var globalCurrentEvent: String = ""

@objc protocol HostConfig: JSExport {
    func createInstance(_ type: String, _ props: JSValue) -> UIView
    func createTextInstance(_ text: String) -> UIView
    func appendInitialChild(_ parent: JSValue, _ child: JSValue)
    func appendChild(_ parent: JSValue, _ child: JSValue)
    func appendChildToContainer(_ container: JSValue, _ child: JSValue)
    func insertBefore(_ parentInstance: JSValue, _ child: JSValue, _ beforeChild: JSValue)
    func insertInContainerBefore(_ container: JSValue, _ child: JSValue, _ beforeChild: JSValue)
    func removeChild(_ parentInstance: JSValue, _ child: JSValue)
    func removeChildFromContainer(_ container: JSValue, _ child: JSValue)
    func resetTextContent(_ instance: JSValue)
    func commitTextUpdate(_ textInstance: JSValue, _ prevText: String, _ nextText: String)
    func commitUpdate(_ instance: JSValue, _ updatePayload: JSValue, _ type: JSValue, _ prevProps: JSValue, _ nextProps: JSValue)
    func hideInstance(_ instance: JSValue)
    func hideTextInstance(_ instance: JSValue)
    func unhideInstance(_ instance: JSValue, _ props: JSValue)
    func unhideTextInstance(_ instance: JSValue, _ text: JSValue)
    func clearContainer(_ cointainer: JSValue)
    func getCurrentEventPriority() -> String

    func setTimeout(_ function: JSValue, _ delay: JSValue)
    func queueMicrotask(_ function: JSValue)
}

class HostConfigImpl: NSObject, HostConfig {
    var rootView: UIView?

    func createInstance(_ type: String, _ props: JSValue) -> UIView {
        return components[type]?.create(props) ?? UIView()
    }

    func createTextInstance(_ text: String) -> UIView {
        return NativeText.create(text)
    }

    func appendInitialChild(_ parent: JSValue, _ child: JSValue) {
        guard let parentView = parent.toObject() as? UIView else {
            return
        }
        guard let childView = child.toObject() as? UIView else {
            return
        }
        parentView.addSubview(childView)
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func appendChild(_ parent: JSValue, _ child: JSValue) {
        guard let parentView = parent.toObject() as? UIView else {
            return
        }
        guard let childView = child.toObject() as? UIView else {
            return
        }
        parentView.addSubview(childView)
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func appendChildToContainer(_ container: JSValue, _ child: JSValue) {
        guard let childView = child.toObject() as? UIView else {
            return
        }
        rootView?.addSubview(childView)
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func insertBefore(_ parentInstance: JSValue, _ child: JSValue, _ beforeChild: JSValue) {
        guard let parentView = parentInstance.toObject() as? UIView else {
            return
        }
        guard let childView = child.toObject() as? UIView else {
            return
        }
        guard let beforeChildView = beforeChild.toObject() as? UIView else {
            return
        }
        parentView.insertSubview(childView, belowSubview: beforeChildView)
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func insertInContainerBefore(_ container: JSValue, _ child: JSValue, _ beforeChild: JSValue) {
        guard let childView = child.toObject() as? UIView else {
            return
        }
        guard let beforeChildView = beforeChild.toObject() as? UIView else {
            return
        }
        rootView?.insertSubview(childView, aboveSubview: beforeChildView)
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func removeChild(_ parentInstance: JSValue, _ child: JSValue) {
        guard let childView = child.toObject() as? UIView else {
            return
        }
        childView.removeFromSuperview()
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func removeChildFromContainer(_ container: JSValue, _ child: JSValue) {
        guard let childView = child.toObject() as? UIView else {
            return
        }
        childView.removeFromSuperview()
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func resetTextContent(_ instance: JSValue) {
        guard let view = instance.toObject() as? UILabel else {
            return
        }
        NativeText.update(view, text: "")
    }

    func commitTextUpdate(_ textInstance: JSValue, _ prevText: String, _ nextText: String) {
        guard let view = textInstance.toObject() as? UILabel else {
            return
        }
        NativeText.update(view, text: nextText)
    }

    func commitUpdate(_ instance: JSValue, _ updatePayload: JSValue, _ type: JSValue, _ prevProps: JSValue, _ nextProps: JSValue) {
        guard let view = instance.toObject() as? UIView else {
            return
        }
        let payload = UpdatePayload(from: updatePayload)
        guard !payload.isEmpty() else {
            return
        }
        components[type.toString()]?.update(view, props: nextProps, updatePayload: payload)
    }

    func hideInstance(_ instance: JSValue) {
        guard let instance = instance.toObject() as? UIView else {
            return
        }
        instance.isHidden = true
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func hideTextInstance(_ instance: JSValue) {
        guard let instance = instance.toObject() as? UILabel else {
            return
        }
        instance.isHidden = true
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func unhideInstance(_ instance: JSValue, _ props: JSValue) {
        guard let instance = instance.toObject() as? UIView else {
            return
        }
        instance.isHidden = false
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func unhideTextInstance(_ instance: JSValue, _ text: JSValue) {
        guard let instance = instance.toObject() as? UIView else {
            return
        }
        instance.isHidden = false
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func clearContainer(_ cointainer: JSValue) {
        rootView?.subviews.forEach { $0.removeFromSuperview() }
        rootView?.yoga.applyLayout(preservingOrigin: true)
    }

    func setTimeout(_ function: JSValue, _ delay: JSValue) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay.toDouble()) {
            function.call(withArguments: [])
        }
    }

    func queueMicrotask(_ function: JSValue) {
        DispatchQueue.main.async {
            function.call(withArguments: [])
        }
    }

    func getCurrentEventPriority() -> String {
        switch globalCurrentEvent {
        case "button", "textfield", "toggle", "segmentedcontrol":
            return "DiscreteEventPriority"

        // sliderのイベントもreact-domではDiscreteEventPriorityだけど
        // サンプルということでContinuousEventPriorityに設定してみてます
        case "slider":
            return "ContinuousEventPriority"

        default:
            return "DefaultEventPriority"
        }
    }
}
