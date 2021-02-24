# KeychainSwiftProperty

```swift
import Foundation
import KeychainSwiftProperty
import KeychainSwift

class Keychain: KeychainProvider {
    let keychain: KeychainSwift = .init(keyPrefix: "app")
    
    @KeychainSwiftProperty(key: "stringProperty")
    var stringProperty: String?
    
    @KeychainSwiftProperty(key: "dataProperty")
    var dataProperty: Data?
}
```
