
import Foundation
import KeychainSwift


struct SharedKeychain {
    
    static var keychain: KeychainSwift?
    static var accessOptions: KeychainSwiftAccessOptions?
    
    static func start(withKeychain keychainSwift: KeychainSwift, accessGroup: String, keychainSwiftAccessOptions: KeychainSwiftAccessOptions = .accessibleWhenUnlocked, synchronizable: Bool = true) {
        keychain = keychainSwift
        if let keychain = keychain {
            keychain.accessGroup = accessGroup
            keychain.synchronizable = synchronizable
            accessOptions = keychainSwiftAccessOptions
        }
    }
    
    @discardableResult
    static func set(value: String, forKey key: String) -> Bool {
        guard let keychain = keychain else { return false }
        return keychain.set(value, forKey: key, withAccess: accessOptions)
    }
    
    @discardableResult
    static func set(value: Bool, forKey key: String) -> Bool {
        guard let keychain = keychain else { return false }
        return keychain.set(value, forKey: key, withAccess: accessOptions)
    }
    
    @discardableResult
    static func set(value: Data, forKey key: String) -> Bool {
        guard let keychain = keychain else { return false }
        return keychain.set(value, forKey: key, withAccess: accessOptions)
    }
    
    @discardableResult
    static func delete(key: String) -> Bool {
        guard let keychain = keychain else { return false }
        return keychain.delete(key)
    }
    
    @discardableResult
    static func clear() -> Bool {
        guard let keychain = keychain else { return false }
        return keychain.clear()
    }
    
    static func get(key: String) -> String? {
        guard let keychain = keychain else { return nil }
        return keychain.get(key)
    }
    
    static func getBool(key: String) -> Bool? {
        guard let keychain = keychain else { return nil }
        return keychain.getBool(key)
    }
    
    static func getData(key: String) -> Data? {
        guard let keychain = keychain else { return nil }
        return keychain.getData(key)
    }
    
}
