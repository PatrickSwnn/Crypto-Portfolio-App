//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 18/05/2024.
//


import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    @Published var overviewStats : [StatsModel] = []
    @Published var additionalStats : [StatsModel] = []
    @Published var coin : CoinModel
    @Published var coinDescription : String? = nil
    @Published var websiteLink : String? = nil
    @Published var redditLink : String? = nil
    
    
    private let coinDetailService : CoinDetailDataService
    var cancellables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    func addSubscribers(){
        coinDetailService.$coinDetail
            .combineLatest($coin)
        //since we need 2 results
            .map(mapDataToStats)
            
            .sink { [weak self] returnedCoinInfo in
                print("Coin Detial Downlaoded")
                self?.overviewStats = returnedCoinInfo.overviewArray
                self?.additionalStats = returnedCoinInfo.additionalArray
            }
            .store(in: &cancellables)
        
        
        coinDetailService.$coinDetail
            .sink { [weak self] returnedCoin in
                self?.coinDescription = returnedCoin?.readableDescription
                self?.websiteLink = returnedCoin?.links?.homepage?.first
                self?.redditLink = returnedCoin?.links?.subredditURL
            }
            .store(in: &cancellables)
        
    }
    
    
   
    
    
    
    private func mapDataToStats(coinDetail:CoinDetailModel?,coinModel:CoinModel) -> (overviewArray:[StatsModel],additionalArray:[StatsModel]) {
        let overviewArray : [StatsModel] = createOverviewArray(coinModel: coinModel)
        let additaionalArray : [StatsModel] = createAdditionalArray(coinDetail: coinDetail, coinModel: coinModel)
        return (overviewArray,additaionalArray)
        
    }
    
    
    private func createOverviewArray(coinModel:CoinModel)->[StatsModel]{

        let currentPrice = "$" + coinModel.currentPrice.asCurrencyWith6Decimals()
        let currentPricePercentChange = coinModel.priceChangePercentage24H
        let currentPriceStats = StatsModel(title: "Current Price", value: "\(currentPrice)", percentChange: currentPricePercentChange)
        
        let marketCapital = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "n/a")
        let marketCapitalPercentChange = coinModel.marketCapChangePercentage24H ?? 0.0
        let marketCapitalStats = StatsModel(title: "Market Capitalization", value: "\(marketCapital)",percentChange: marketCapitalPercentChange)
        
        let rank = coinModel.rank
        let rankStats = StatsModel(title: "Rank", value: "\(rank)")
        
        
        let volume = "$" +  (coinModel.totalVolume?.formattedWithAbbreviations() ?? "n/a")
        let volumeStats = StatsModel(title: "Volume", value: volume)
        
        let overview : [StatsModel] = [currentPriceStats,marketCapitalStats,rankStats,volumeStats]
        return overview
        
    }
    
    
    private func createAdditionalArray(coinDetail:CoinDetailModel?,coinModel:CoinModel)->[StatsModel]{
        let hourHigh = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let hourHighStats = StatsModel(title: "24h High", value: hourHigh)
        
        let hourLow = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let hourLowStats = StatsModel(title: "24h Low", value: hourLow)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let priceChangePercent  = coinModel.priceChangePercentage24H
        let priceChangeStats = StatsModel(title: "24h Price Change", value: priceChange, percentChange: priceChangePercent)
        
        
        let marketCapChange = coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "n/a"
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStats = StatsModel(title: "24h Market Cap Change", value: marketCapChange, percentChange: marketCapPercentChange)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = (blockTime == 0 ? "n/a" : "\(blockTime)")
        let blockStats = StatsModel(title: "Block Time", value: blockTimeString)
        
        let hash = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashStats = StatsModel(title: "Hashing Algorithm", value: hash)
        
        let additional : [StatsModel] = [hourHighStats,hourLowStats,priceChangeStats,marketCapStats,blockStats,hashStats]
        return additional
        
    }
    
}
