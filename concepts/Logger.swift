//
//  Logger.swift
//  Yokohama
//
//  Created by Роман Анистратенко on 10/03/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation



class Logger {

    static let shared = Logger()

    private init() {}

    private let loggerQueue = DispatchQueue(label: "com.logger")

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

    func info(_ message: String,
              filename: String = #file,
              function: String = #function,
              line: Int = #line) {
        #if DEBUG
        loggerQueue.async {
            let infoLevel: LogLevel = .info
            print("[\(infoLevel.symbol) \(infoLevel.title)] [\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
        }
        #endif
    }

    func warning(_ message: String,
                 filename: String = #file,
                 function: String = #function,
                 line: Int = #line) {
        #if DEBUG
        loggerQueue.async {
            let warningLevel: LogLevel = .warning
            print("[\(warningLevel.symbol) \(warningLevel.title)] [\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
        }
        #endif
    }

    func error(_ message: String,
               filename: String = #file,
               function: String = #function,
               line: Int = #line) {
        #if DEBUG
        loggerQueue.async {
            let errorLevel: LogLevel = .error
            print("[\(errorLevel.symbol) \(errorLevel.title)] [\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
        }
        #endif
    }

}
