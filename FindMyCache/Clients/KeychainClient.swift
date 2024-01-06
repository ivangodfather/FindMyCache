//
//  KeychainClient.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import ComposableArchitecture
import Foundation

private enum Constants: String {
  case service = "com.findmycache.FindMyCache"
}

enum KeychainAccount: String {
  case userIdentifier
  
  var kSecClass: CFString {
    switch self {
    case.userIdentifier: return kSecClassGenericPassword
    }
  }
}

enum KeychainError: Error {
  case notFound
  case unhandledError
}

@DependencyClient
struct KeychainClient {
  var delete: (KeychainAccount) throws -> Void
  var get: (KeychainAccount) throws -> String
  var set: (String, KeychainAccount) throws -> Void
}

extension KeychainClient: DependencyKey {
  static let liveValue = KeychainClient(delete: deleteValue, get: getValue, set: setValue)
}

extension DependencyValues {
  var keychainClient: KeychainClient {
    get { self[KeychainClient.self] }
    set { self[KeychainClient.self] = newValue }
  }
}

private func getValue(using account: KeychainAccount) throws -> String {
  var query = keychainQuery(account)
  query[kSecMatchLimit as String] = kSecMatchLimitOne
  query[kSecReturnData as String] = kCFBooleanTrue
  
  var queryResult: AnyObject?
  let status = withUnsafeMutablePointer(to: &queryResult) {
    SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
  }
  
  guard status != errSecItemNotFound else { throw KeychainError.notFound }
  guard 
    status == noErr,
    let data = queryResult as? Data,
    let value = String(data: data, encoding: .utf8) else {
    throw KeychainError.unhandledError
  }
  
  return value
}

private func setValue(_ value: String, for account: KeychainAccount) throws -> Void {
  let data = value.data(using: String.Encoding.utf8)!
  
  do {
    // Check for an existing item in the keychain.
    try _ = getValue(using: account)
    
    var attributesToUpdate = [String: AnyObject]()
    attributesToUpdate[kSecValueData as String] = data as AnyObject?
    
    let query = keychainQuery(account)
    let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    
    guard status == noErr else { throw KeychainError.unhandledError }
  } catch KeychainError.notFound {
    /*
     Not found in the keychain. Create a dictionary to save
     as a new keychain item.
     */
    var newItem = keychainQuery(account)
    newItem[kSecValueData as String] = data as AnyObject?
    
    // Add a the new item to the keychain.
    let status = SecItemAdd(newItem as CFDictionary, nil)
    guard status == noErr else { throw KeychainError.unhandledError }
  }
}

private func keychainQuery(_ account: KeychainAccount) -> [String: AnyObject] {
  var query = [String: AnyObject]()
  query[kSecClass as String] = account.kSecClass
  query[kSecAttrService as String] = Constants.service.rawValue as AnyObject?
  query[kSecAttrAccount as String] = account.rawValue as AnyObject?
  return query
}

private func deleteValue(_ account: KeychainAccount) throws {
  let query = keychainQuery(account)
  let status = SecItemDelete(query as CFDictionary)
  guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError }
}
