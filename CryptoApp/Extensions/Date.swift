//
//  Date.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 28/05/2024.
//

import Foundation

extension Date {
   // "2021-03-13T23:18:10.268Z",
    
    init(coinGeckoString:String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    
    func asShortDateString()->String{
       return  shortDateFormatter.string(from: self) //self means whatever class is calling this method
    }
    
    private var shortDateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    
    
    
    
    
}
