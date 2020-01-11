//
//  Data+PrettyPrintedJSON.swift
//  swift-vault
//
//  Created by Roman Anistratenko on 11.01.2020.
//  Copyright © 2020 m3rk edge. All rights reserved.
//

import Foundation

extension Data {
    
    /// Use in console or print statement to get fine printed JSON string from Data
    var prettyPrintedJSONString: NSString {
        // NSString gives us a nice sanitized debugDescription
        guard
            let object = try? JSONSerialization.jsonObject(
                with: self,
                options: []),
            let data = try? JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]),
            let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue)
        else {
            return "Can't convert Data to JSON string"
        }
        return prettyPrintedString
    }
}
