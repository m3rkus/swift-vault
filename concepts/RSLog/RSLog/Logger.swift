//
//  Logger.swift
//  RSLog
//
//  Created by m3rk on 27/05/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


internal protocol Logger {
    
    func info(_ message: String,
              filename: String,
              function: String,
              line: UInt)
    
    func warning(_ message: String,
                 filename: String,
                 function: String,
                 line: UInt)
    
    func error(_ message: String,
               filename: String,
               function: String,
               line: UInt)
    
}
