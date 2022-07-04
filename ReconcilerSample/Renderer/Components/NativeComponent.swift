import JavaScriptCore
import UIKit

protocol NativeComponent {
    static func create(_ props: JSValue) -> UIView
    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload)
}
