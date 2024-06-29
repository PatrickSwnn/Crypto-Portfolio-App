//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 18/05/2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetail : CoinDetailModel? = nil
    private var coinDetailSubscription : AnyCancellable?
    let coin : CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        downloadCoinDetail()
    }
    
    func downloadCoinDetail(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        coinDetailSubscription =  NetworkingManager.downloadData(forURL: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler
                  , receiveValue: {[weak self] returnedCoins in
                self?.coinDetail = returnedCoins
                self?.coinDetailSubscription?.cancel()
            })
            

        
    }
    
    
    
}
