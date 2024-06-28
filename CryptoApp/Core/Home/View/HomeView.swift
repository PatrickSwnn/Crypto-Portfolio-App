//
//  HomeView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/04/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio:Bool = false // slide right
    @State private var clickedPortfolio : Bool = false //add portfolio
    @State private var clickedSettings : Bool = false // new sheet
    @EnvironmentObject private var vm: HomeViewModel
    
    //custom lazy navigation
    @State private var selectedCoin : CoinModel? = nil
    @State private var isNavigated : Bool = false
    
    @EnvironmentObject  var authVM : SignInAndOutViewModel
    
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea(.all)
            //injecting the sheet view at the top level
                .sheet(isPresented: $clickedPortfolio, content: {
                    PortfolioView()
                })
                .sheet(isPresented: $clickedSettings, content: {
                    SettingView()
                })
            VStack {
                
             
                
                homeHeader
                  
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                columnHeadings
                
               
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                ZStack(alignment:.top){
                    if showPortfolio {
                        if vm.holdingCoins.isEmpty && vm.searchText.isEmpty {
                            VStack(spacing:20) {
                                Image(systemName: "circle.badge.plus")
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color.theme.accent)
                                
                                Text("Add Coins to Your Portfolio")
                                    .font(.callout)
                                    .foregroundStyle(Color.theme.accent)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                
                              
                            }
                            
                            .padding(50)

                        } else {
                            allHoldingCoinsList
                        }

                    }
                }
               
                Spacer(minLength: 0)
                .transition(.move(edge: .trailing))
                
                  
                }
            
            }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $isNavigated,
                label: {
                    EmptyView()
                })
        
        
        )
        
        
        
        .refreshable {
            vm.reloadData()
        }
        }
        
        
    }


//#Preview {
//    //the previw won't work if I dont's pass the enviorment object into the preview provider
//    NavigationStack {
//        HomeView()
//            .navigationBarBackButtonHidden(true)
//            .preferredColorScheme(.dark)
//        
//    } .environmentObject(DeveloperPreview.shared.vm)
//
//}



extension HomeView  {
    private var homeHeader:some View  {
        HStack {
            CircleButtonView(icon: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        clickedPortfolio.toggle()
                    } else {
                        clickedSettings.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(isAnimated: $showPortfolio)
                )
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Price")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.heavy)
                .animation(.none)
            Spacer()
            CircleButtonView(icon: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        self.showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
    
    
    
    private var allCoinsList : some View {
        List {
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showCenterColumn: false)
                    .listRowBackground(Color.theme.background)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())

    }
    
    private var allHoldingCoinsList : some View {
        List {
            ForEach(vm.holdingCoins,id:\.id){ holding in
                CoinRowView(coin: holding, showCenterColumn: true)
                    .listRowBackground(Color.theme.background)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: holding)
                    }

            }

        }
        .listStyle(PlainListStyle())

    }
    //for lazy navigation
    /*
     1.We will pass the selected coin to the next view ( need selectedCoin State var )
     2.We will add a bool value to let the system know when to intialize so that it will prevent uncessary initializations
     */
    private func segue(coin:CoinModel){
        selectedCoin = coin
        isNavigated.toggle()
    }
    
    
    private var columnHeadings : some View {
        HStack{
            HStack(spacing:4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sort == .rank || vm.sort == .rankReverse ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sort == .rank ? 0 : 180))
            }
            .onTapGesture {
                vm.sort = vm.sort == .rank ? .rankReverse : .rank
                //this code change the rank to rankReverse sort if it is already rank sort
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing:4){
                    Text("Holdings")
                        .animation(.none)
                    Image(systemName: "chevron.down")
                        .opacity(vm.sort == .holdings || vm.sort == .holdingsReverse ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sort == .holdings ? 0 : 180))
                }
                
                .onTapGesture {
                    vm.sort = vm.sort == .holdings ? .holdingsReverse : .holdings
                   
                }
                
            }
            HStack(spacing:4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sort == .price || vm.sort == .priceReverse ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sort == .price ? 0 : 180))
            }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                .onTapGesture {
                    vm.sort = vm.sort == .price ? .priceReverse : .price
                  
                }
            
            
            
            
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)){
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0)  , anchor: .center)
           
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
        
    }
    
    
}
