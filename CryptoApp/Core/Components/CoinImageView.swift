//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 04/05/2024.
//

import SwiftUI





struct CoinImageView: View {
    @StateObject var coinImageVM : CoinImageViewModel
    
    //to pass the coin into CoinImageVM, we will init here
    
        init(coin:CoinModel){
        
        //to reference the stateObject, we have to add underscore _
        _coinImageVM = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    
 
    
    var body: some View {
        if let image = coinImageVM.coinImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else if coinImageVM.loading {
            ProgressView()
        } else {
            Image(systemName: "questionmark")
                .foregroundStyle(Color.theme.secondaryText)
        }
        
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.shared.coin)
        .padding()
        .previewLayout(.sizeThatFits)
}

