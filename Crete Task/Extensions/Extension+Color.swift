//
//  Extension+Color.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // Skip "#"

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
    
    // Function to lighten the color by a percentage
    func lighter(by percentage: CGFloat) -> Color {
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let newRed = min(red + (1 - red) * (percentage / 100), 1)
            let newGreen = min(green + (1 - green) * (percentage / 100), 1)
            let newBlue = min(blue + (1 - blue) * (percentage / 100), 1)
            
            return Color(red: newRed, green: newGreen, blue: newBlue)
        }
        
        return self // Return the original color if conversion fails
    }
}
