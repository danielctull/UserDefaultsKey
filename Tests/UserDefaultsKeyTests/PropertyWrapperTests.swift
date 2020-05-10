
import UserDefaultsKey
import XCTest

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
final class PropertyWrapperTests: XCTestCase {

    func testGet() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let key = UserDefaults.Key(.random, default: "")
        let userDefault = UserDefault(key, defaults: defaults)
        let value = String.random
        defaults.set(value, for: key)
        XCTAssertEqual(userDefault.wrappedValue, value)
    }

    func testSet() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: UUID().uuidString))
        let key = UserDefaults.Key(UUID().uuidString, default: "")
        var userDefault = UserDefault(key, defaults: defaults)
        userDefault.wrappedValue = "value"
        XCTAssertEqual(defaults.value(for: key), "value")
    }

    func testDefault() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let defaultValue = String.random
        let key = UserDefaults.Key(.random, default: defaultValue)
        let userDefault = UserDefault(key, defaults: defaults)
        XCTAssertEqual(userDefault.wrappedValue, defaultValue)
    }

    func testRemove() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let defaultValue = String.random
        let value = String.random
        let key = UserDefaults.Key(.random, default: defaultValue)
        let userDefault = UserDefault(key, defaults: defaults)

        defaults.set(value, for: key)
        XCTAssertEqual(userDefault.wrappedValue, value)

        defaults.removeValue(for: key)
        XCTAssertEqual(userDefault.wrappedValue, defaultValue)
    }

    func testIncorrectType() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let keyString = String.random
        let defaultValue = String.random
        let key = UserDefaults.Key(keyString, default: defaultValue)
        let userDefault = UserDefault(key, defaults: defaults)
        defaults.set(1.23, forKey: keyString)
        XCTAssertEqual(userDefault.wrappedValue, defaultValue)
    }

    func testNil() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let key = UserDefaults.Key<Int?>(.random)
        let userDefault = UserDefault(key, defaults: defaults)
        XCTAssertNil(userDefault.wrappedValue)
    }

    func testSetNil() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let value = String.random
        let key = UserDefaults.Key<String?>(.random)
        let userDefault = UserDefault(key, defaults: defaults)

        defaults.set(value, for: key)
        XCTAssertEqual(userDefault.wrappedValue, value)

        defaults.set(nil, for: key)
        XCTAssertNil(userDefault.wrappedValue)
    }
}
