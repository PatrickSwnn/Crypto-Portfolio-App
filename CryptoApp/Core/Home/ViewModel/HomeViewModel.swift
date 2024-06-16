//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 21/04/2024.
//

import Foundation
import Observation
import SwiftUI
import Combine

class HomeViewModel : ObservableObject {
    @Published var allStats : [StatsModel] = []
    @Published var allCoins:[CoinModel] = []
    @Published var holdingCoins:[CoinModel] = []
    @Published var searchText : String = ""
    @Published var isLoading : Bool = false
    @Published var sort : SortOptions = .holdings
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init() {
        addSubscribers()
        
    }
    //we will subscribe to coin data service class to listen to changes
    func addSubscribers(){
        
        $searchText
        //also subscribe the allCoins using combine
            //and sort at the top level as well
            .combineLatest(coinDataService.$allCoins, $sort)
        //timer before every publishers publish new values
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        //fliter logic here
            .map(searchAndSort) // get filteredCoins at this step
            .sink { [weak self ] filteredCoins in
                self?.allCoins = filteredCoins
            }
        
            .store(in: &cancellables)
        
        //add portfolioData subsriber
        
        //first we will resubsribe the allCoins ( the flitered one )
        //this is becoz,we will need to work with the coins for that view
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(transformCoinIntoPortfolio)
            .sink { [weak self] returnedCoins in
                //we can add the sort here to the holdings since it will be subscribe at this stage
                guard let self = self else { return }
                self.holdingCoins = self.sortPortfolioIfNeeded(coin: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        
        //add marketDataSubscriber
        marketDataService.$marketData
        //combine the portfolio values
            .combineLatest($holdingCoins)
        //we have to map the values of market data and transform them into StatsModel  array
            .map(transformMarketData)
            .sink { [weak self] returnedStats in
                self?.allStats = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    
    func updatePortfolioList(coin:CoinModel,amount:Double){
        //this is for UI
        portfolioDataService.refreshPortfolio(coin: coin, amount: amount)
        
    }
    
    func reloadData(){
        //need to call coindataservice and marketdataservice again
        // loader
        isLoading = true
        coinDataService.downloadCoins()
        marketDataService.downloadMarketData()
        //since the data are already in sink as subscribers, we will set isLoading as false at the bottom level of subsriber which is marketDataService.
        //vibration service
        HapticManager.notification(result: .success)
    }
    
    
    private func searchAndSort(text:String,startingCoins:[CoinModel],sort:SortOptions)-> [CoinModel] {
        var updatedCoins = searchFiltering(text: text, startingCoins: startingCoins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    
    
    
    
    private func searchFiltering(text:String,startingCoins:[CoinModel])->[CoinModel]{
        //if there is no text in search field, just return
        guard !text.isEmpty else {
            return startingCoins }
        //if there is text,
        // make everything lowercased, first
        let lowercasedText = text.lowercased()
        let filteredCoins = startingCoins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.id.contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText)
        }
        return filteredCoins
    }
    
    private func sortCoins(sort:SortOptions,coins: inout [CoinModel]){ // inout basically means the input inout var will only be transformed in place and won't become a new data type, in this case a new array
        switch sort {
        case .rank,.holdings:
            coins.sort (by: { $0.rank < $1.rank }) //sorts the collection inplace instead of making a new array
            
        case .rankReverse,.holdingsReverse:
            coins.sort(by: {$0.rank > $1.rank })
        case .price :
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReverse:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
            //we can sort the holdings here since we haven't subscribe it at subscribing search text
            //and at this stage the coins are semi sorted ( only holdings need to be sort if needed )
        }
        
        
    }
    
    
    
    
    
    private func transformCoinIntoPortfolio(coins:[CoinModel],portfolios:[Portfolio])->[CoinModel]{
        //make map to coin again to check whether their in the portfolio or not
        coins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolios.first(where: {$0.coinID == coin.id}) else { return nil }// we use compact map since we want to return nil if there is no coin in portfolio
                return coin.updateHoldings(amount: entity.amount)
                
            }
    }
    
    
    
    private func sortPortfolioIfNeeded(coin:[CoinModel]) -> [CoinModel] { //we can't use in out here since the returned coin in the sink block will need a new array to assign since its value is mutable
        switch sort {
        case .holdings:
            return coin.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReverse:
            return coin.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coin
        }
        
    }
    
    
    
    
    private func transformMarketData(marketDataModel : MarketDataModel?,holdingCoins: [CoinModel])->[StatsModel]{
        var marketStats : [StatsModel] = []
        //make sure there is actually data in marketDataModel
        guard let marketStatsData = marketDataModel else { return marketStats } //we are returning empty array if there is no data
        //map to all 3 required infos
        let marketCap = StatsModel(title: "Market Cap", value: marketStatsData.marketCap,percentChange: marketStatsData.marketCapChangePercentage24hUsd)
        let volume = StatsModel(title: "24h Volume", value: marketStatsData.volume)
        let btcDominacne = StatsModel(title: "BTC Dominance", value: marketStatsData.btcDominance)
        
        let myPortfolio : StatsModel
        //we need value and percent change calculations for myPortfolio
        let portfolioValue = holdingCoins
            .map({$0.currentHoldingsValue})
        //since it is an array, + every values
            .reduce(0, +)
        
        
        // FOR PERCENT CHANGE FORMULA (CURRENT VALUE - OLD VALUE) / OLD VALUE
        //percent change means change over 24 hours in percent
        let previousValue = holdingCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0.0) / 100  //to change into % representation since its result is 25 for 25% instead of 0.25
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(0, +)
        let percentChange = ((portfolioValue - previousValue) / previousValue) * 100 //to change into % representation since it result is just 0.25 for 25
        
        
        
        myPortfolio = StatsModel(title: "Portfolio", value: portfolioValue.asCurrencyWith2Decimals(), percentChange: percentChange)
        
        marketStats.append(contentsOf: [
            marketCap,
            volume,
            btcDominacne,
            myPortfolio
        ])
        
        return marketStats
    }
    
    
    
    enum SortOptions {
        case rank, rankReverse, holdings, holdingsReverse, price, priceReverse
    }
    
    
    
}

