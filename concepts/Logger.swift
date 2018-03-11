//
//  Logger.swift
//  Yokohama
//
//  Created by Роман Анистратенко on 10/03/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

class Logger {
    
    private enum LogLevel {
        case info
        case warning
        case error
        
        var title: String {
            switch self {
            case .info:
                return "INFO"
            case .warning:
                return "WARNING"
            case .error:
                return "ERROR"
            }
        }
        
        var symbol: String {
            switch self {
            case .info:
                return "✅"
            case .warning:
                return "⚠️"
            case .error:
                return "⛔️"
            }
        }
    }
    
    var isEnabled = true
    
    func info(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
        if isEnabled {
            let infoLevel: LogLevel = .info
            print("[\(infoLevel.symbol) \(infoLevel.title)] [\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
        }
    }
    
    func warning(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
        if isEnabled {
            let warningLevel: LogLevel = .warning
            print("[\(warningLevel.symbol) \(warningLevel.title)] [\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
        }
    }
    
    func error(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
        if isEnabled {
            let errorLevel: LogLevel = .error
            print("[\(errorLevel.symbol) \(errorLevel.title)] [\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
        }
    }

}
