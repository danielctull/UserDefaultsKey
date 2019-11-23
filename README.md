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
