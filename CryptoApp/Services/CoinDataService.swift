//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 04/05/2024.
//

import Foundation
import Combine


class CoinDataService : ObservableObject {
    @Published var allCoins : [CoinModel] = [] // this is a publisher
    private var coinSubscription : AnyCancellable?
    
    init(){
        downloadCoins()
    }
    
    func downloadCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en#") else { return }
        //it can be confusing when we create a set of cancellables ( if there are a lot of parsing sessions, we are not gonna know which one we are going to cancel) So, now we can cancel the last one
        coinSubscription =  NetworkingManager.downloadData(forURL: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler
                  , receiveValue: {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
            

        
              
        
    
        
        
    }
    
 
        
    
    
    
}
