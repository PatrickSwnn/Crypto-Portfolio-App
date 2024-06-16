//
//  StatsModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 11/05/2024.
//

import Foundation

struct StatsModel : Identifiable {
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentChange : Double?
    
    init(title: String, value: String, percentChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentChange = percentChange
    }
}
