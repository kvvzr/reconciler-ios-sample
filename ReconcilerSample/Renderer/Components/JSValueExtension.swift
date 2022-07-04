import JavaScriptCore

extension JSValue {
    func getSafeString(_ propKey: String) -> String? {
        guard let string = objectForKeyedSubscript(propKey), !string.isUndefined else {
            return nil
        }
        return string.toString()
    }

    func getSafeInt32(_ propKey: String) -> Int32? {
        guard let int = objectForKeyedSubscript(propKey), !int.isUndefined else {
            return nil
        }
        return int.toInt32()
    }

    func getSafeDouble(_ propKey: String) -> Double? {
        guard let double = objectForKeyedSubscript(propKey), !double.isUndefined else {
            return nil
        }
        return double.toDouble()
    }

    func getSafeBool(_ propKey: String) -> Bool? {
        guard let bool = objectForKeyedSubscript(propKey), !bool.isUndefined else {
            return nil
        }
        return bool.toBool()
    }

    func getSafeObject(_ propKey: String) -> JSValue? {
        guard let object = objectForKeyedSubscript(propKey), !object.isUndefined else {
            return nil
        }
        return object
    }
}
