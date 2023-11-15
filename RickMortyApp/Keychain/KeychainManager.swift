//
//  KeychainManager.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 13.11.2023.
//

import Foundation
import Security

class KeychainManager {
    // MARK: - properties
    private let serviceName = "YourAppService"
    private let usernameKey = "Username"
    private let passwordKey = "Password"
    
    // MARK: - func to save data
    func saveCredentials(username: String, password: String) {
        let credentials = "\(username):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecValueData as String: credentialsData
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // MARK: - func to check the data
    func isValidCredentials(username: String, password: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let existingItem = item as? [String: Any],
              let storedData = existingItem[kSecValueData as String] as? Data,
              let storedCredentials = String(data: storedData, encoding: .utf8) else {
            return false
        }
        
        let components = storedCredentials.components(separatedBy: ":")
        return components.count == 2 && components[0] == username && components[1] == password
    }
}
