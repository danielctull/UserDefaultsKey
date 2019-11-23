
import Foundation

/// A property wrappy for a value in user defaults.
@propertyWrapper
public struct UserDefault<Value> {

    private let defaults: UserDefaults
    private let key: UserDefaults.Key<Value>

    /// Creates a UserDefault property wrapper to access the value for the given
    /// key.
    ///
    /// - Parameters:
    ///   - key: The key for the desired value
    ///   - defaults: The user defaults storage to access.
    public init(_ key: UserDefaults.Key<Value>,
                defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
    }

    /// The value stored in userd defaults for the given key.
    public var wrappedValue: Value {
        get { defaults.value(for: key) }
        set { defaults.set(newValue, for: key) }
    }
}
