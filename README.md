# Defaults

A package to specify a Key type for use with UserDefaults. 

## Usage

Generally you will want to extend the UserDefaults.Key to add a static property to allow easy access to the  key.

```swift
extension UserDefaults.Key where Value == Bool {
    static let somePreference = UserDefaults.Key("somePreference", default: false)
}
```

Then you can access the value using the key with shorthand syntax. The value you get back will be the one specified at the declaration of the key. 

```swift
let somePreference = UserDefaults.standard.value(for: .somePreference)
if somePreference {

} else {

}
```

Because the key has the type of the value, you can only store a value of the correct type for that key.

```swift
UserDefaults.standard.set(true, for: .somePreference) // Works

UserDefaults.standard.set("true", for: .somePreference) // Fails to compile
```

## Optional Values

Keys can be defined with optional values, and can either then fall back to a default value or nil. The initialiser that only takes the key name will return a key that falls back to nil. When declaring optional keys, you will also need to supply the type for Value as a generic parameter. 

```swift
extension UserDefaults.Key where Value == String? {
    static let optionalPreference = UserDefaults.Key<String?>("optionalPreference")
}
```

## Property Wrapper

Once you have defined a key, you can pass it to the UserDefault property wrapper to allow succinct definitions of properties that are backed by user defaults.

```swift
struct Foo {
    @UserDefault(.somePreference) var somePreference
}
```

Because Swift infers the value type from the key, you don't need to specify it in the property definition. For clarity however, it may be desirable to do so.

```swift
struct Foo {
    @UserDefault(.somePreference) var somePreference: Bool
    
    func bar() {
        
        if somePreference {
        
        } else {
        
        }
    }
}
```
