//
//  String.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 29/05/2024.
//

import Foundation

extension String {
    
    var removingHTMLOccurences : String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression,range: nil)
        // self here means whatever object that is calling this method
    }
}
