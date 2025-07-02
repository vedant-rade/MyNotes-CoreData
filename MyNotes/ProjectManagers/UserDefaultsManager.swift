//
//  UserDefaultsManager.swift
//  MyNotes
//
//  Created by apple on 02/07/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let username = "username"
    }
}

extension UserDefaultsManager {
    func getUsername() -> String? {
        return defaults.string(forKey: Keys.username)
    }
    
    func setUsername(_ username: String?) {
        defaults.set(username, forKey: Keys.username)
    }
}
