
#if canImport(Combine) && canImport(SwiftUI)

import Combine
import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private final class Observable<Value>: ObservableObject {

    let objectWillChange: ObservableObjectPublisher
    let defaults: UserDefaults
    let key: UserDefaults.Key<Value>
    var observation: KeyValueObservation<Value>

    var value: Value {
        get { defaults[key] }
        set { defaults[key] = newValue }
    }

    init(defaults: UserDefaults, key: UserDefaults.Key<Value>) {
        let objectWillChange = ObservableObjectPublisher()
        self.defaults = defaults
        self.key = key
        self.objectWillChange = objectWillChange
        self.observation = KeyValueObservation(
            object: defaults,
            keyPath: key.name,
            default: key.default
        ) { change in
            guard case .willSet = change else { return }
            objectWillChange.send()
        }
    }
}

/// A property wrapper for a value in user defaults.
///
/// This should not be used directly, instead use the typealias UserDefault.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct _DynamicUserDefault<Value>: DynamicProperty {

    let defaults: UserDefaults
    let key: UserDefaults.Key<Value>
    @ObservedObject private var observable: Observable<Value>

    /// Creates a dynamic UserDefault property wrapper to access the value for
    /// the given key.
    ///
    /// - Parameters:
    ///   - key: The key for the desired value
    ///   - defaults: The user defaults storage to access.
    public init(_ key: UserDefaults.Key<Value>, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
        observable = Observable(defaults: defaults, key: key)
    }

    /// The value stored in userd defaults for the given key.
    public var wrappedValue: Value {
        get { observable.value }
        set { observable.value = newValue }
    }

    /// A binding to the value in stored in user defaults.
    public var projectedValue: Binding<Value> { $observable.value }

    public mutating func update() { _observable.update() }
}

#endif
