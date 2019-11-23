import XCTest
import Defaults

extension UserDefaults.Key where Value == Bool? {
    static let optionalPreference = UserDefaults.Key<Bool?>("optionalPreference")
}

final class KeyTests: XCTestCase {

    func testGet() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let keyString = String.random
        let key = UserDefaults.Key(keyString, default: "")
        let value = String.random
        defaults.set(value, forKey: keyString)
        XCTAssertEqual(defaults.value(for: key), value)
    }

    func testSet() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let key = UserDefaults.Key(.random, default: "")
        let value = String.random
        defaults.set(value, for: key)
        XCTAssertEqual(defaults.value(for: key), value)
    }

    func testDefault() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let defaultValue = String.random
        let key = UserDefaults.Key(.random, default: defaultValue)
        XCTAssertEqual(defaults.value(for: key), defaultValue)
    }

    func testRemove() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let defaultValue = String.random
        let value = String.random
        let key = UserDefaults.Key(.random, default: defaultValue)

        defaults.set(value, for: key)
        XCTAssertEqual(defaults.value(for: key), value)

        defaults.removeValue(for: key)
        XCTAssertEqual(defaults.value(for: key), defaultValue)
    }

    func testIncorrectType() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let keyString = String.random
        let defaultValue = String.random
        let key = UserDefaults.Key(keyString, default: defaultValue)
        defaults.set(1.23, forKey: keyString)
        XCTAssertEqual(defaults.value(for: key), defaultValue)
    }

    func testNil() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let key = UserDefaults.Key<Int?>(.random)
        XCTAssertNil(defaults.value(for: key))
    }

    func testSetNil() throws {
        let defaults = try Unwrap(UserDefaults(suiteName: .random))
        let value = String.random
        let key = UserDefaults.Key<String?>(.random)

        defaults.set(value, for: key)
        XCTAssertEqual(defaults.value(for: key), value)

        defaults.set(nil, for: key)
        XCTAssertNil(defaults.value(for: key))
    }
}
