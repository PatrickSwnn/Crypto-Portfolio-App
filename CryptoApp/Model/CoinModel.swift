//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 14/04/2024.
//

import Foundation




//GeckoCoin API info
/*
url = https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en#

 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
 "current_price": 63323,
 "market_cap": 1249936194709,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 1333640421056,
 "total_volume": 52216438774,
 "high_24h": 67936,
 "low_24h": 61514,
 "price_change_24h": -3066.530640237499,
 "price_change_percentage_24h": -4.61903,
 "market_cap_change_24h": -59853737793.53882,
 "market_cap_change_percentage_24h": -4.56972,
 "circulating_supply": 19681962,
 "total_supply": 21000000,
 "max_supply": 21000000,
 "ath": 73738,
 "ath_change_percentage": -13.74921,
 "ath_date": "2024-03-14T07:10:36.635Z",
 "atl": 67.81,
 "atl_change_percentage": 93692.20148,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "roi": null,
 "last_updated": "2024-04-14T02:38:09.943Z",
 "sparkline_in_7d": {
    "price": [
        68988.34002109112,
        68981.9017907012
        ]
 },
 "price_change_percentage_24h_in_currency": -4.619027220517359
 
 
 
 
 */

struct CoinModel: Identifiable,Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice : Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
//    let roi: JSONNull?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    //Since this is a model, we can even make a new variable that is not included in a JSON data, it won't be included in networking session
    let currentHoldings:Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
//        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount:Double) -> CoinModel {
        return CoinModel(id: self.id, symbol: self.symbol, name: self.name, image: self.image, currentPrice: self.currentPrice, marketCap: self.marketCap, marketCapRank: self.marketCapRank, fullyDilutedValuation: self.fullyDilutedValuation, totalVolume: self.totalVolume, high24H: self.high24H, low24H: self.low24H, priceChange24H: self.priceChange24H, priceChangePercentage24H: self.priceChangePercentage24H, marketCapChange24H: self.marketCapChange24H, marketCapChangePercentage24H: self.marketCapChangePercentage24H, circulatingSupply: self.circulatingSupply, totalSupply: self.totalSupply, maxSupply: self.maxSupply, ath: self.ath, athChangePercentage: self.athChangePercentage, athDate: self.athDate, atl: self.atl, atlChangePercentage: self.atlChangePercentage, atlDate: self.atlDate, lastUpdated: self.lastUpdated, sparklineIn7D: self.sparklineIn7D, priceChangePercentage24HInCurrency: self.priceChangePercentage24HInCurrency, currentHoldings: amount )
   }
    
    
    
    var currentHoldingsValue : Double {
        return (currentHoldings ?? 0.0) * currentPrice
    }
    
    
    var rank : Int {
        return Int(marketCapRank ?? 0)
    }
    
    
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
