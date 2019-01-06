//
//  Obfuscator.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 07/01/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

final class Obfuscator {
    
    private let XORByte: UInt8 = 116
    
    func deobfuscate(_ obfuscatedChars: [UInt8]) -> String? {
        
        return String(bytes: obfuscatedChars.map{$0 ^ XORByte},
                      encoding: .utf8)
    }
    
    func obfuscate(_ string: String) -> [UInt8] {
        
        let stringData = [UInt8](string.utf8)
        var obfuscatedData: [UInt8] = []
        
        stringData.forEach {
            obfuscatedData.append($0 ^ XORByte)
        }
        
        return obfuscatedData
    }
    
}
