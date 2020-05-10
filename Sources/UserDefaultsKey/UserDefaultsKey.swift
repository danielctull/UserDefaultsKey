
import Foundation

extension UserDefaults {

    /// Represents a key in UserDefaults.
    public struct Key<Value> {

        let name: String
        let `default`: Value

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
        public init<T>(_ name: String) where Value == T? {
            self.init(name, default: nil)
        }
    }
}
