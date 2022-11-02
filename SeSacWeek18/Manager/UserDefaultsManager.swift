//
//  UserDefaultsManager.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation


@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: self.key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.key)
        }
    }
}


class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    
    @UserDefault(key: "token", defaultValue: "")
    var token: String
}
