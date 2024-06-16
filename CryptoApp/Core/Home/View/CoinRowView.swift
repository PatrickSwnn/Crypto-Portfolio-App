//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 19/04/2024.
//

import SwiftUI
import Kingfisher

struct CoinRowView: View {
    
    
    let coin : CoinModel
    let showCenterColumn :Bool
    var body: some View {
        HStack(spacing:0){
            leftColumn
            Spacer()
            
            if showCenterColumn {
                centerColumn
            }
            
            rightColumn
            
        }
        .font(.subheadline) //formats every font that are not formatted to subheadline
        .background(
        //since the background is added here, the entire row becomes clickable instead of the coin names and images.
            Color.theme.background.opacity(0.0001)
        
        )
        
    }
}



extension CoinRowView {
    private var leftColumn : some View {
        HStack(spacing:0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
           CoinImageView(coin: coin)
                .frame(width:30,height:30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .padding(.horizontal,6)
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment:.trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? "0.0")

        }
    }
    
    private var rightColumn : some View {
        VStack(alignment:.trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
                
            Text("\(coin.priceChangePercentage24H?.asPercentWith2Decimals() ?? "")")
                .foregroundStyle(
                    coin.priceChangePercentage24H ?? 0 >= 0 ?
                    Color.theme.green :
                        Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing) // takes 1/3.5 of the width

    }
    
    
}

struct CoinRowView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin:  DeveloperPreview.shared.coin  ,showCenterColumn:true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: DeveloperPreview.shared.coin,showCenterColumn:true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
        }
    }
    
}
