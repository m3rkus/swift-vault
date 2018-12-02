//
//  ApplicationInfo.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

final class ApplicationInfo {
    
    fileprivate init() {}
    
    fileprivate static func getString(_ key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String
            else { return "" }
        
        return value
    }
    
    static var name: String = {
        let displayName = ApplicationInfo.getString("CFBundleDisplayName")
        
        return !displayName.isEmpty
            ? displayName
            : ApplicationInfo.getString("CFBundleName")
    }()
    
    static var version: String = {
        return ApplicationInfo.getString("CFBundleShortVersionString")
    }()
    
    static var build: String = {
        return ApplicationInfo.getString("CFBundleVersion")
    }()
    
    static var bundle: String = {
        return ApplicationInfo.getString("CFBundleIdentifier")
    }()
    
}
