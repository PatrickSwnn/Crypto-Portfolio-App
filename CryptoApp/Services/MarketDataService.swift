//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/05/2024.
//

import Foundation
import Combine

class MarketDataService : ObservableObject {
    @Published var marketData : MarketDataModel? = nil // this is a publisher
    private var marketSubscription : AnyCancellable?
    
    init(){
        downloadMarketData()
    }
    
    func downloadMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        //it can be confusing when we create a set of cancellables ( if there are a lot of parsing sessions, we are not gonna know which one we are going to cancel) So, now we can cancel the last one
        marketSubscription =  NetworkingManager.downloadData(forURL: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler
                  , receiveValue: {[weak self] returnedMarketData in
                self?.marketData = returnedMarketData.data
                self?.marketSubscription?.cancel()
            })
            

        
              
        
    
        
        
    }
    
 
        
    
    
    
}
