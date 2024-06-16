//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 16/05/2024.
//

import Foundation
import SwiftUI
class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(result:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(result)
    }
}
