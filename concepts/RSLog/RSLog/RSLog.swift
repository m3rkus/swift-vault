//
//  RSLog.swift
//  RSLog
//
//  Created by m3rk on 27/05/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


// MARK: - Properties
final public class RSLog {
    
    public init() {
    }
    
    // MARK: Private var
    private let logQueue = DispatchQueue(label: "com.m3rk.log")
    
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
    
}

// MARK: - Public func
extension RSLog: Logger {
    
    public func info(_ message: String,
                     filename: String = #file,
                     function: String = #function,
                     line: UInt = #line) {
        log(level: .info,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func warning(_ message: String,
                        filename: String = #file,
                        function: String = #function,
                        line: UInt = #line) {
        log(level: .warning,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func error(_ message: String,
                      filename: String = #file,
                      function: String = #function,
                      line: UInt = #line) {
        log(level: .error,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
}

// MARK: - Private func
extension RSLog {
    
    private func log(level: LogLevel,
                     message: String,
                     filename: String,
                     function: String,
                     line: UInt) {
        #if DEBUG
        logQueue.async { [weak self] in
            guard let `self` = self else { return }
            print("[\(level.symbol) \(level.title)] [\(self.format(filename)):\(line)] \(function) - \(message)")
        }
        #endif
    }
    
    private func format(_ filename: String) -> String {
        return filename.components(separatedBy: "/").last?
            .components(separatedBy: ".").first ?? "???"
    }
    
}
