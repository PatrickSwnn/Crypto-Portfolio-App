//
//  DetailView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 18/05/2024.
//

import SwiftUI


struct DetailLoadingView :  View {
    @Binding var coin : CoinModel?
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
        
    }
    
    
    
}


// there might be cases that api calls maybe executed even before making sure that the view has a coin
// to prevent that, make a separate new view that will make sure that the view has a coin. and if that view has a coin initialize this DetailView().






struct DetailView: View {
    
    @StateObject private var vm : DetailViewModel
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    let gridSpacing : CGFloat = 30

    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    @State private var isExpanded : Bool = false
    
    var body: some View {
        ScrollView {
            VStack{
                
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing:20){
                    
                    overviewHeading
                    Divider()
                    
                    
                    descriptionSection
           
                    
                    
                    
                    overviewGrid
                    
                    additionalHeading
                    Divider()
                    additionalGrid

                    linksURLSection
                    
                   
                }
                .padding()
            }
        }
        .background(
            Color.theme.background
        )
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                toolBarTrailingItems
            }
        }
    }
}

extension DetailView {
    
    
    
    
    private var toolBarTrailingItems : some View {
            HStack {
                Text(vm.coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundStyle(Color.theme.secondaryText)
                CoinImageView(coin: vm.coin)
                    .frame(width:25,height:25)
            }
        
    }
    
    
    
    
    private var overviewHeading : some View {
        
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
       
    }
    
    
    private var descriptionSection : some View {
        VStack(alignment:.leading) {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                Text(coinDescription)
                    .lineLimit(isExpanded ? .none : 3)
                    .font(.callout)
                    .foregroundStyle(Color.theme.secondaryText)
                Button {
                    withAnimation(.easeInOut){
                        isExpanded.toggle()
                    }
                } label: {
                    Text(isExpanded ? "see less" : "read more")
                        
                }
                .padding(.vertical,4)
                .tint(.blue)
                .font(.headline)
                .bold()
                

            }
        }
    }
    
    private var overviewGrid : some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: gridSpacing ,
                  pinnedViews: [] ,
                  
                  content: {
            ForEach(vm.overviewStats){ stat in
                StatsView(stat: stat)
                
            }
        })
    }
    private var additionalHeading : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var additionalGrid : some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: gridSpacing ,
                  pinnedViews: [] ,
                  
                  content: {
            ForEach(vm.additionalStats) { stat in
                StatsView(stat: stat)
                
            }
        })
    }
    
    private var linksURLSection : some View {
        
        VStack(alignment:.leading,spacing:20){
            if let websiteString = vm.websiteLink, let webURL = URL(string: websiteString){
                Link("Website", destination: webURL)
            }
            if let redditString = vm.redditLink, let redditURL = URL(string: redditString){
                Link("Reddit", destination: redditURL)
            }
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .font(.headline)
        .bold()
        .tint(.blue)

    }
    
}



#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.shared.coin)
    }
}
