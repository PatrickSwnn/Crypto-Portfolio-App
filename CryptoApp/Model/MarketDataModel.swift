//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/05/2024.
//

import Foundation

/*
 
 url = https://api.coingecko.com/api/v3/global
 
 "data": {
 "active_cryptocurrencies": 14183,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 1088,
 "total_market_cap": {
 "btc": 38882698.20971014,
 "eth": 813743114.6342589,
 "ltc": 29055492858.15887,
 "bch": 5477620994.056641,
 "bnb": 4023528766.43701,
 "eos": 3029063692588.0244,
 "xrp": 4694518684305.659,
 "xlm": 22399716434244.285,
 "link": 177483925325.36435,
 "dot": 355015319421.6569,
 "yfi": 348701182.90497404,
 "usd": 2365788322329.9214,
 "aed": 8689540507917.79,
 "ars": 2085892812011999,
 "aud": 3570447736060.3203,
 "bdt": 276544004462155.4,
 "bhd": 890310021977.4524,
 "bmd": 2365788322329.9214,
 "brl": 12199897220590.932,
 "cad": 3236043556698.984,
 "chf": 2153096854787.498,
 "clp": 2187353706273666.8,
 "cny": 17096842468981.668,
 "czk": 54723759420310.15,
 "dkk": 16383084132134.709,
 "eur": 2193010069573.523,
 "gbp": 1896498721770.948,
 "gel": 6328483762232.541,
 "hkd": 18488280870759.98,
 "huf": 851715365118143.5,
 "idr": 37982731515006904,
 "ils": 8808359860618.492,
 "inr": 197653688939785.12,
 "jpy": 368530675910943.7,
 "krw": 3243732368746559,
 "kwd": 726457888561.2047,
 "lkr": 706633609172213.6,
 "mmk": 4963579084133187,
 "mxn": 39698874364025.13,
 "myr": 11211470859521.51,
 "ngn": 3521976007586817,
 "nok": 25864290752142.125,
 "nzd": 3930208434660.369,
 "php": 136190146360040.66,
 "pkr": 657205643253555.6,
 "pln": 9452616068132.04,
 "rub": 218246156357557.06,
 "sar": 8872886737110.068,
 "sek": 25701640439193.594,
 "sgd": 3205406597924.812,
 "thb": 86449898748623.53,
 "try": 76661482686020.11,
 "twd": 76744990282221.52,
 "uah": 93553294110046.84,
 "vef": 236886384714.89536,
 "vnd": 60228830847947700,
 "zar": 43898101320394.24,
 "xdr": 1790925417886.9758,
 "xag": 83952340748.31635,
 "xau": 1002242564.8718505,
 "bits": 38882698209710.14,
 "sats": 3888269820971014.5
 },
 "total_volume": {62 items},
 "market_cap_percentage": {10 items},
 "market_cap_change_percentage_24h_usd": -0.368849004462601,
 "updated_at": 1715501672
 
 
 
 */  // URL Info

struct GlobalData : Codable {
    let data : MarketDataModel?
}

struct MarketDataModel : Codable {
    let totalMarketCap,totalVolume,marketCapPercentage : [String:Double]?
    let marketCapChangePercentage24hUsd : Double?
    
    enum CodingKeys : String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUsd = "market_cap_change_percentage_24h_usd"
    }
    
    
    
    //make computed properties to be mapped later on
    
    //required properties - (1)Market Cap, (2)Volume, (3) BTC Domaince
    
    var marketCap : String {
        if let returnedData = totalMarketCap?.first(where: {$0.key == "usd"}){
            return "$\(returnedData.value.formattedWithAbbreviations())"
        }
        return "Invalid"
    }
    
    var volume : String {
        if let returnedData = totalVolume?.first(where: {$0.key == "usd"}){
            return "$\(returnedData.value.formattedWithAbbreviations())"
        }
        return "Invalid"
    }
    
    var btcDominance : String {
        if let returnedData = marketCapPercentage?.first(where: {$0.key == "btc"}){
            return "\(returnedData.value.asPercentWith2Decimals())"
        }
        return "Invalid"
        
    }
    
}



