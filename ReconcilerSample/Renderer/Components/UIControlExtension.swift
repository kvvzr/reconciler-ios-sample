import UIKit

private var currentActionKey = "currentAction"

extension UIControl {
    private var currentAction: UIAction? {
        get {
            return objc_getAssociatedObject(self, &currentActionKey) as? UIAction
        }
        set {
            objc_setAssociatedObject(self, &currentActionKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    func replaceAction(_ action: UIAction, for controlEvents: UIControl.Event) {
        if currentAction != nil {
            removeAction(currentAction!, for: controlEvents)
        }
        currentAction = action
        addAction(action, for: controlEvents)
    }
}
