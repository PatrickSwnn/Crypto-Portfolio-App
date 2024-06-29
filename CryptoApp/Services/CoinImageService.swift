//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 04/05/2024.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService : ObservableObject  {
    @Published var coinImage : UIImage? = nil
    private var imageSubscription : AnyCancellable?
    private let coin : CoinModel
    private let fileManager = LocalFileManager.instance
    
    //hard code the folderName here since this vm won't be generic and will be specific for a single view
     let folderName = "CoinImages"
    let imageName : String
    
    
    init(coin : CoinModel){
        self.coin = coin
            //using coin id as a name for images
        self.imageName = coin.id
        getImage()
        
    }
    
    
    
    private func getImage(){
        if let returnedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            coinImage = returnedImage
            print("RETRIEVING IMAGE FROM FILE MANAGER")
        } else {
            downloadImage(coin: coin)
        }
    }
    
    
    
    
    
    private func downloadImage(coin:CoinModel){
        guard let url = URL(string: coin.image) else { return }
        imageSubscription =  NetworkingManager.downloadData(forURL: url)
            .tryMap({ data -> UIImage? in
                UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler
                
                  , receiveValue: {[weak self] returnedImage in
            
                guard let self = self, let safeImage = returnedImage  else { return }
                self.coinImage = safeImage
                self.imageSubscription?.cancel()
                print("DOWNLOADED IMAGE FROM INTERNET")
                self.fileManager.saveImage(desiredImage: safeImage, imageName: self.imageName, folderName: self.folderName)

            })
            

        
              
        
    
        
        
    }
    
}
