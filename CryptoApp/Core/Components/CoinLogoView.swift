//
//  CoinScrollView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/05/2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin : CoinModel
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width:50,height:50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.5)

        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.shared.coin)
}
