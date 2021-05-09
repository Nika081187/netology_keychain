//
//  KeychainService.swift
//  com.work.with.filemanager
//
//  Created by v.milchakova on 05.05.2021.
//

import Foundation
import Security

// see https://stackoverflow.com/a/37539998/1694526
// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class KeyChain {

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func remove(key: String) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : Data() ] as [String : Any]

        return SecItemDelete(query as CFDictionary)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}

//public class KeychainService: NSObject {
//
//    class func updatePassword(service: String, account:String, data: String) {
//        if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
//
//            // Instantiate a new default keychain query
//            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue])
//
//            let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataValue:dataFromString] as CFDictionary)
//
//            if (status != errSecSuccess) {
//                if let err = SecCopyErrorMessageString(status, nil) {
//                    print("Read failed: \(err)")
//                }
//            }
//        }
//    }
//
//
//    class func removePassword(service: String, account:String) {
//
//        // Instantiate a new default keychain query
//        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, kCFBooleanTrue as Any], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue])
//
//        // Delete any existing items
//        let status = SecItemDelete(keychainQuery as CFDictionary)
//        if (status != errSecSuccess) {
//            if let err = SecCopyErrorMessageString(status, nil) {
//                print("Remove failed: \(err)")
//            }
//        }
//
//    }
//
//
//    class func savePassword(service: String, account:String, data: String) {
//        if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
//
//            // Instantiate a new default keychain query
//            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
//
//            // Add the new keychain item
//            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
//
//            if (status != errSecSuccess) {    // Always check the status
//                if let err = SecCopyErrorMessageString(status, nil) {
//                    print("Write failed: \(err)")
//                }
//            }
//        }
//    }
//
//    class func loadPassword(service: String, account:String) -> String? {
//        // Instantiate a new default keychain query
//        // Tell the query to return a result
//        // Limit our results to one item
//        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, kCFBooleanTrue as Any, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
//
//        var dataTypeRef :AnyObject?
//
//        // Search for the keychain items
//        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
//        var contentsOfKeychain: String?
//
//        if status == errSecSuccess {
//            if let retrievedData = dataTypeRef as? Data {
//                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
//            }
//        } else {
//            print("Nothing was retrieved from the keychain. Status code \(status)")
//        }
//
//        return contentsOfKeychain
//    }
//
//}
