
// This doesn't need Combine or SwiftUI, but only the dynamic property wrapper
// uses this, so it's not needed on systems that can't import these frameworks.
#if canImport(Combine) && canImport(SwiftUI)

import Foundation

/// A class to observe values using a string-based keypath.
final class KeyValueObservation<Value>: NSObject {

    enum Change {
        case willSet(oldValue: Value, newValue: Value)
        case didSet(oldValue: Value, newValue: Value)
    }

    private weak var object: NSObject? {
        willSet {
            guard newValue == nil else { return }
            removeObserver()
        }
    }

    private let keyPath: String
    private let `default`: Value
    private let handler: (Change) -> Void

    init(object: NSObject,
         keyPath: String,
         default: Value,
         handler: @escaping (Change) -> Void) {

        self.object = object
        self.keyPath = keyPath
        self.default = `default`
        self.handler = handler
        super.init()
        addObserver()
    }

    deinit {
        removeObserver()
    }

    private func addObserver() {
        object?.addObserver(self, forKeyPath: keyPath, options: [.old, .new, .prior], context: nil)
    }

    private func removeObserver() {
        object?.removeObserver(self, forKeyPath: keyPath, context: nil)
    }

    // swiftlint:disable block_based_kvo
    // swiftlint:disable discouraged_optional_collection
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change dictionary: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        guard self.object == object as? NSObject else { return }
        guard let dictionary = dictionary else { return }
        handler(change(for: dictionary))
    }
    // swiftlint:enable discouraged_optional_collection
    // swiftlint:enable block_based_kvo

    private func change(for values: [NSKeyValueChangeKey: Any]) -> Change {
        let old = values[.oldKey] as? Value ?? `default`
        let new = values[.newKey] as? Value ?? `default`
        let isPrior = values[.notificationIsPriorKey] as? Bool ?? false

        if isPrior {
            return .willSet(oldValue: old, newValue: new)
        } else {
            return .didSet(oldValue: old, newValue: new)
        }
    }
}

#endif
