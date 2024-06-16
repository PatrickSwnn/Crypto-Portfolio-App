//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 05/05/2024.
//

import SwiftUI
import Foundation
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var coinImage : UIImage? = nil
    @Published var loading : Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    private let dataService : CoinImageService
    
    private let coin : CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.subscribeImageServive()
        self.loading = true
    }
    
    
    private func subscribeImageServive(){
        dataService.$coinImage
            .sink { [weak self] _ in
                self?.loading = false
            } receiveValue: { [weak self] returnedImage in
                self?.coinImage = returnedImage
            }
            .store(in: &cancellables)

        
    }
}
