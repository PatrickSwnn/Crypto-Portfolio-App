//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/05/2024.
//

import Foundation
import Combine

class MarketDataService : ObservableObject {
    @Published var marketData : MarketDataModel? = nil
    private var marketSubscription : AnyCancellable?
    
    init(){
        downloadMarketData()
    }
    
    func downloadMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
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
