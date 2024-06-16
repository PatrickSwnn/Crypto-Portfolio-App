//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 10/05/2024.
//

import Foundation
import UIKit
import SwiftUI
extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
