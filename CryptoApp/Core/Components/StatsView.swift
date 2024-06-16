//
//  StatsView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 11/05/2024.
//

import SwiftUI


struct StatsView: View {
    let stat : StatsModel
    var body: some View {
        VStack(alignment:.leading,spacing:4){
            Text(stat.title)
                .foregroundStyle(Color.theme.secondaryText)
                .font(.caption)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(alignment:.center,spacing:4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentChange ?? 0.0 >= 0) ? 0 : 180))
                    
                
                Text(stat.percentChange?.asPercentWith2Decimals() ?? "")
                
                    .font(.caption)
                .bold()
            }
            .foregroundStyle((stat.percentChange ?? 0.0 >= 0) ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentChange == nil ? 0.0 : 1.0)
            
        }
    }
}

#Preview {
    StatsView(stat: DeveloperPreview.shared.stat4)
}
