//
//  Double.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 19/04/2024.
//

import Foundation
extension Double {
    
    /// Converts a Double into Currency with 2...6 Decimal Places
    /// ```
    /// Converts 1234.2203 into $1234.32
    /// Converts 1234 into $1234.00
    /// Converts 0.31234 into $0.31234
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        /*
         these 3 will be set by default to usd
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.locale = .autoupdatingCurrent // tracks the user location
         
        */
//        formatter.locale = .current // tracks the user location
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    //make a function to access the private var
    /// Converts a Currency with 2..6 Decimal Places into String
    /// ```
    /// Converts $1234.32 into "$1234.32"
    /// Converts 1234.00 into "$1234.00"
    /// Converts 0.31234 into "$0.31234"
    /// ```
    func asCurrencyWith6Decimals()->String{
        let number = NSNumber(value:self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
        
    }
    
    
    /// Converts a Double into Currency with 2...6 Decimal Places
    /// ```
    /// Converts 1234.2203 into $1234.32
    /// Converts 1234 into $1234.00
    /// Converts 0.31234 into $0.31
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        /*
         these 3 will be set by default to usd
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.locale = .autoupdatingCurrent // tracks the user location
         
        */
        formatter.locale = .current // tracks the user location
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    //make a function to access the private var
    /// Converts a Currency with 2..6 Decimal Places into String
    /// ```
    /// Converts $1234.32 into "$1234.32"
    /// Converts 1234.00 into "$1234.00"
    /// Converts 0.31234 into "$0.31"
    /// ```
    func asCurrencyWith2Decimals()->String{
        let number = NSNumber(value:self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
        
    }
    
    
    
    
    
    
    
    
    /// Converts a Number into String with 2 decimal places
    ///  ```
    ///  Converts 2023.2223 into "2023.22"
    ///  ```
    func asNumberString()->String{
        return String(format:"%.2f",self)
    }
    
    /// Combine a String with 2 decimal places with" %"
    ///  ```
    ///  Converts "2023.22" into "2023.22%"
    ///  ```
    func asPercentWith2Decimals()->String{
        return asNumberString() + "%"
    }
    
    
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
    
    
}
