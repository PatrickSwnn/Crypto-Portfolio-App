//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 11/05/2024.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject var vm : HomeViewModel
    @Binding var showPortfolio:Bool

    var body: some View {
        HStack{
            ForEach(vm.allStats,id: \.id){ stat in
            StatsView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3) // for fitting in 3 elements
                
                
            } 
        } .frame(maxWidth: UIScreen.main.bounds.width,
                 alignment: showPortfolio ? .trailing : .leading )
    }
}

#Preview {
    HomeStatsView( showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.shared.vm)
}
