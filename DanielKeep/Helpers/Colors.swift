//
//  Colors.swift
//  DanielKeep
//
//  Created by Dani Benet on 29/12/23.
//

import Foundation
import SwiftUI

extension Color {
    
    // Utility initializer to pass from hex to Color
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
    
    func toHex() -> String? {
        // Convert Color to UIColor (for iOS)
        let uiColor = UIColor(self)
        
        // Extract RGBA components
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Format to hexadecimal string
        let hexString = String(format: "#%02lX%02lX%02lX",
                               lroundf(Float(red * 255)),
                               lroundf(Float(green * 255)),
                               lroundf(Float(blue * 255)))
        
        return hexString
    }
}
