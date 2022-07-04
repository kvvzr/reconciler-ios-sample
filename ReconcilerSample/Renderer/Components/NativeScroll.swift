import JavaScriptCore
import SwiftYogaKit
import UIKit

struct NativeScroll: NativeComponent {
    static func create(_ props: JSValue) -> UIView {
        let scroll = NativeScrollView()
        let isHorizontal = props.objectForKeyedSubscript("horizontal").toBool()
        scroll.yoga.flexDirection = isHorizontal ? .row : .column
        scroll.yoga
            .width(.auto)
            .height(.auto)
            .maxWidth(.percent(100))
            .maxHeight(.percent(100))

        scroll.bounces = true
        scroll.alwaysBounceHorizontal = isHorizontal
        scroll.alwaysBounceVertical = !isHorizontal

        update(scroll, props: props, updatePayload: .all)

        return scroll
    }

    static func update(_ view: UIView, props: JSValue, updatePayload: UpdatePayload) {
    }
}

final class NativeScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)
        delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let frame = subviews.first?.frame else {
            return
        }
        contentSize = frame.size
    }
}

extension NativeScrollView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        superview?.subviews.forEach { $0.yoga.isIncludedInLayout = false }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        superview?.subviews.forEach { $0.yoga.isIncludedInLayout = !decelerate }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        superview?.subviews.forEach { $0.yoga.isIncludedInLayout = true }
    }
}
