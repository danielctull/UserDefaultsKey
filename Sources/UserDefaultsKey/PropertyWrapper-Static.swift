
#if !(canImport(Combine) && canImport(SwiftUI))

import Foundation

/// A property wrapper for a value in user defaults.
@propertyWrapper
public struct UserDefault<Value> {

    private let defaults: UserDefaults
    private let key: UserDefaultsKey<Value>

    /// Creates a static UserDefault property wrapper to access the value for
    /// the given key. The value doesn't automatically update upon changes to
    /// the user defaults.
    ///
    /// - Parameters:
    ///   - key: The key for the desired value
    ///   - defaults: The user defaults storage to access.
    public init(_ key: UserDefaultsKey<Value>,
                defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
    }

    /// The value stored in userd defaults for the given key.
    public var wrappedValue: Value {
        get { defaults[key] }
        set { defaults[key] = newValue }
    }
}

#endif
