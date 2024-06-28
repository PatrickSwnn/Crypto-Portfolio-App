//
//  Color.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/04/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = Theme()
    static let launch = Launch()
}

struct Theme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}


struct ThemeTest {
    //can play around different colors here and change the initializer
}


struct Launch {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}


