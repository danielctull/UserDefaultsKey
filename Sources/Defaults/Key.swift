
import Foundation

extension UserDefaults {

    /// Represents a key in UserDefaults.
    public struct Key<Value> {

        fileprivate let name: String
        fileprivate let `default`: Value

        /// Creates a UserDefaults key.
        ///
        /// - Parameters:
        ///   - name: The name of the key.
        ///   - default: The value to use if the key isn't found in the
        ///              defaults.
        public init(_ name: String, default: Value) {
            self.name = name
            self.default = `default`
        }

        /// Creates a UserDefaults key for an optional value.
        ///
        /// - Parameters:
        ///   - name: The name of the key.
        public init<T>(_ name: String) where Value == Optional<T> {
            self.init(name, default: nil)
        }
    }
}

extension UserDefaults {

    /// Returns the value associated with the specified key.
    ///
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The value associated with the specified key, or the key's
    ///            default if the value was not found.
    public func value<Value>(for key: Key<Value>) -> Value {
        object(forKey: key.name) as? Value ?? key.default
    }

    /// Sets the value of the specified default key.
    ///
    /// The value parameter can be only property list objects. For arrays and
    /// dictionaries, their contents must be property list objects.
    ///
    /// - Parameters:
    ///   - value: The value to store in the defaults database.
    ///   - key: The key with which to associate the value.
    public func set<Value>(_ value: Value, for key: Key<Value>) {
        set(value, forKey: key.name)
    }

    /// Sets the value of the specified default key.
    ///
    /// The value parameter can be only property list objects. For arrays and
    /// dictionaries, their contents must be property list objects.
    ///
    /// - Parameters:
    ///   - value: The value to store in the defaults database.
    ///   - key: The key with which to associate the value.
    public func set<Value>(_ value: Value?, for key: Key<Value?>) {

        // Note this is needed to prevent a crash in UserDefaults when setting a
        // nil value. This will override the previous set method when the Key's
        // Value is optional.

        guard let value = value else {
            removeValue(for: key)
            return
        }

        set(value, forKey: key.name)
    }

    /// Removes the value of the specified key.
    ///
    /// - Parameter key: The key whose value you want to remove.
    public func removeValue<Value>(for key: Key<Value>) {
        removeObject(forKey: key.name)
    }
}
