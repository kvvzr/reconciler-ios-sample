import Foundation
import JavaScriptCore

enum UpdatePayload {
    case all
    case some(props: [String])

    init(from value: JSValue) {
        guard value.isArray else {
            self = .all
            return
        }
        self = .some(props: value.toArray().compactMap { $0 as? String })
    }

    func shouldUpdate(_ propKey: String) -> Bool {
        if case .all = self {
            return true
        }

        guard case let .some(props) = self else {
            return false
        }
        return props.contains(propKey)
    }

    func isEmpty() -> Bool {
        if case .all = self {
            return false
        }
        guard case let .some(props) = self else {
            return false
        }
        return props.isEmpty
    }
}
