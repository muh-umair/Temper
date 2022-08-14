//
//  ColorExtension.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

// MARK: ColorExtension
extension Color {
    static var appPurple: Color {
        Color(red: 109/255.0, green: 67/255.0, blue: 217/255.0)
    }
    
    static var appGreen: Color {
        Color(red: 116/255.0, green: 250/255.0, blue: 147/255.0)
    }
    
    static var primary: Color {
        appGreen
    }
}
