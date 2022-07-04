import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeSegmentedControl: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let segments = UISegmentedControl()
        segments.yoga.width(.auto).height(.point(32))
        update(segments, props: props, updatePayload: .all)
        return segments
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
        guard let segments = view as? UISegmentedControl else {
            return
        }

        updateItems(segments, props: props, updatePayload: updatePayload)
        updateSelectedIndex(segments, props: props, updatePayload: updatePayload)
        updateOnChange(segments, props: props, updatePayload: updatePayload)
    }

    private static func updateItems(_ view: UISegmentedControl, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("items") else {
            return
        }
        let currentItems = (0 ..< view.numberOfSegments).compactMap { view.titleForSegment(at: $0) }

        var newItems = [String]()
        if let jsItems = props.objectForKeyedSubscript("items").toArray() {
            for item in jsItems {
                if let itemString = item as? String {
                    newItems.append(itemString)
                }
            }
        }

        if currentItems == newItems {
            return
        }
        view.setItems(items: newItems)
    }

    private static func updateSelectedIndex(_ view: UISegmentedControl, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("selectedIndex") else {
            return
        }
        guard let selectedIndex = props.getSafeInt32("selectedIndex") else {
            return
        }
        view.selectedSegmentIndex = Int(selectedIndex)
    }

    private static func updateOnChange(_ view: UISegmentedControl, props: JSValue, updatePayload: UpdatePayload) {
        guard updatePayload.shouldUpdate("onChange") else {
            return
        }
        guard let onChange = props.getSafeObject("onChange") else {
            return
        }
        view.replaceAction(.init { _ in
            globalCurrentEvent = "segmentedcontrol"
            onChange.call(withArguments: [view.selectedSegmentIndex])
            globalCurrentEvent = ""
        }, for: .valueChanged)
    }
}

extension UISegmentedControl {
    func setItems(items: [String]) {
        removeAllSegments()
        for item in items {
            insertSegment(withTitle: item, at: numberOfSegments, animated: false)
        }
    }
}
