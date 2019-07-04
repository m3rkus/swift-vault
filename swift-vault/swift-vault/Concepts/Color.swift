//
//  ColorConstructor.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(hex: UInt32,
                     useAlpha alphaChannel: Bool = false) {
        
        let mask = 0xFF
        let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
        let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
        let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
        let a = alphaChannel ? Int(hex) & mask : 255
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func toHex() -> UInt32 {
        
        func roundToHex(_ x: CGFloat) -> UInt32 {
            return UInt32(roundf(Float(x) * 255.0))
        }
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: nil)

        let colorToInt = roundToHex(r) << 16 | roundToHex(g) << 8 | roundToHex(b)
        return colorToInt
    }
    
    convenience init(colorString: String) {
        
        let leftParenCharset: CharacterSet = CharacterSet(charactersIn: "( ")
        let commaCharset: CharacterSet = CharacterSet(charactersIn: ", ")
        
        let colorString = colorString.lowercased()
        
        if colorString.hasPrefix("#")
        {
            var argb: [UInt] = [255, 0, 0, 0]
            let colorString = colorString.unicodeScalars
            var length = colorString.count
            var index = colorString.startIndex
            let endIndex = colorString.endIndex
            
            index = colorString.index(after: index)
            length = length - 1
            
            if length == 3 || length == 6 || length == 8
            {
                var i = length == 8 ? 0 : 1
                while index < endIndex
                {
                    var c = colorString[index]
                    index = colorString.index(after: index)
                    
                    var val = (c.value >= 0x61 && c.value <= 0x66) ? (c.value - 0x61 + 10) : c.value - 0x30
                    argb[i] = UInt(val) * 16
                    if length == 3
                    {
                        argb[i] = argb[i] + UInt(val)
                    }
                    else
                    {
                        c = colorString[index]
                        index = colorString.index(after: index)
                        
                        val = (c.value >= 0x61 && c.value <= 0x66) ? (c.value - 0x61 + 10) : c.value - 0x30
                        argb[i] = argb[i] + UInt(val)
                    }
                    
                    i += 1
                }
            }
            
            self.init(red: CGFloat(argb[1]) / 255.0, green: CGFloat(argb[2]) / 255.0, blue: CGFloat(argb[3]) / 255.0, alpha: CGFloat(argb[0]) / 255.0)
        }
        else if colorString.hasPrefix("rgba")
        {
            var a: Float = 1.0
            var r: Int32 = 0
            var g: Int32 = 0
            var b: Int32 = 0
            let scanner: Scanner = Scanner(string: colorString)
            scanner.scanString("rgba", into: nil)
            scanner.scanCharacters(from: leftParenCharset, into: nil)
            scanner.scanInt32(&r)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&g)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&b)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanFloat(&a)
            self.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: CGFloat(a)
            )
        }
        else if colorString.hasPrefix("argb")
        {
            var a: Float = 1.0
            var r: Int32 = 0
            var g: Int32 = 0
            var b: Int32 = 0
            let scanner: Scanner = Scanner(string: colorString)
            scanner.scanString("argb", into: nil)
            scanner.scanCharacters(from: leftParenCharset, into: nil)
            scanner.scanFloat(&a)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&r)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&g)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&b)
            self.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: CGFloat(a)
            )
        }
        else if colorString.hasPrefix("rgb")
        {
            var r: Int32 = 0
            var g: Int32 = 0
            var b: Int32 = 0
            let scanner: Scanner = Scanner(string: colorString)
            scanner.scanString("rgb", into: nil)
            scanner.scanCharacters(from: leftParenCharset, into: nil)
            scanner.scanInt32(&r)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&g)
            scanner.scanCharacters(from: commaCharset, into: nil)
            scanner.scanInt32(&b)
            self.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: 1.0
            )
        } else {
            self.init(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0
            )
        }
    }
    
}
