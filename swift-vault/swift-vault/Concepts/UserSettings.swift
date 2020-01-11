//
//  SettingsService.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


@propertyWrapper
struct UserSetting<T> {
    
    let key: String
    let defaultValue: T

    init(
        key: String,
        defaultValue: T) {
        
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct CodableUserSetting<T: Codable> {
    
    let key: String
    let defaultValue: T

    init(
        key: String,
        defaultValue: T) {
        
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                return value
            } catch {
                print("ERROR: Unable to decode JSON of type \(T.self)")
                return defaultValue
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print("ERROR: Unable to encode JSON of type \(T.self)")
            }
        }
    }
}

/// Usage
struct UserSettings {
    
    @UserSetting(
        key: "hasSeenAppIntroduction",
        defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}
