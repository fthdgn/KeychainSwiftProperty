import Foundation
import KeychainSwift

public protocol KeychainProvider {
    var keychain: KeychainSwift { get }
}

@propertyWrapper
public struct KeychainSwiftProperty<T: Codable> {
    let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public static subscript<E: KeychainProvider>(
        _enclosingInstance instance: E,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<E, T?>,
        storage storageKeyPath: ReferenceWritableKeyPath<E, Self>
    ) -> T? {
        get {
            let wrapper = instance[keyPath: storageKeyPath]
            
            switch T.self {
            case is String.Type:
                return instance.keychain.get(wrapper.key) as? T
            case is Bool.Type:
                return instance.keychain.getBool(wrapper.key) as? T
            case is Data.Type:
                return instance.keychain.getData(wrapper.key) as? T
            default:
                if let data = instance.keychain.getData(wrapper.key) {
                    if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                        return decoded
                    } else {
                        print("KeychainProperty cannot decode \(wrapper.key)")
                        return nil
                    }
                } else {
                    return nil
                }
            }
        }
        set {
            let wrapper = instance[keyPath: storageKeyPath]
            guard let newValue = newValue else {
                instance.keychain.delete(wrapper.key)
                return
            }
            switch T.self {
            case is String.Type:
                instance.keychain.set(newValue as! String, forKey: wrapper.key)
            case is Bool.Type:
                instance.keychain.set(newValue as! Bool, forKey: wrapper.key)
            case is Data.Type:
                instance.keychain.set(newValue as! Data, forKey: wrapper.key)
            default:
                if let data = try? JSONEncoder().encode(newValue) {
                    instance.keychain.set(data, forKey: wrapper.key)
                } else {
                    print("KeychainProperty cannot encode \(wrapper.key)")
                }
            }
        }
    }
    
    @available(*, unavailable,
    message: "This property wrapper can only be applied to classes"
    )
    public var wrappedValue: T? {
        get {
            fatalError()
        }
        set {
            fatalError()
        }
    }
}
