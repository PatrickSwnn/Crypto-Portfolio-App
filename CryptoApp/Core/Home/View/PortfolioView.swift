//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/05/2024.
//

import SwiftUI

struct PortfolioView: View {
    //since sheet is considered a another environment
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var portfolioTextField : String = ""
    @State private var showPortfolio : Bool = false

    var body: some View {
        NavigationStack  {
            ScrollView {
                VStack(alignment:.leading,spacing:4){
                    SearchBarView(searchText: $vm.searchText)
                    coinList
                    
                    if selectedCoin != nil {
                        inputField
                    }
                    
                } .navigationBarTitle("My Portfolio")
            }
            .background (
                Color.theme.background
            )
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkView()
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    trailingToolBarItems
                }
                
                
                
                
            }
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
            
        }
        
    }
}






extension PortfolioView {
    private var coinList : some View {
        ScrollView(.horizontal,showsIndicators: false){
            //only loads the view when it appears on screen
            LazyHStack {
                ForEach( vm.searchText.isEmpty ? vm.holdingCoins :      vm.allCoins,id:\.id){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                               
                        )
                    
                        .onTapGesture {
                            withAnimation{
                                //putting the current holdings value in the textField and making on tap appeareances
                                updateSelectedCoin(coin: coin)
                            }
                        }
                } //ForEach
            }
            .frame(height:120)
            .padding(.leading)
            
       
            
        }
    }
    
    private func updateSelectedCoin(coin:CoinModel){
        selectedCoin = coin
        //check if the coin is included in portfolio
        if let portfolio = vm.holdingCoins.first(where: {$0.id == coin.id }),
           let amount = portfolio.currentHoldings {
            return portfolioTextField = "\(amount)"
        } else {
            return portfolioTextField = ""
        }
    }




   private var inputField : some View {
        VStack(spacing:20) {
            
            
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "") ")
                Spacer()
                Text("\(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")")
            }
            Divider()
            
            HStack {
                Text("Amount in your Portfolio")
                Spacer()
                TextField("Ex 1.4", text: $portfolioTextField)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                
            }
            
            Divider()
            
            
            HStack {
                Text("Current Value")
                Spacer()
                //need computed property
                Text(getCurrentValue().asCurrencyWith2Decimals())
                
            }
            
            
            
            
            
            
        } // end of VStack
        .animation(.none)
        .font(.headline)
        .padding()
    }
    
    
    private func getCurrentValue()->Double{
        if let quantity = Double(portfolioTextField){
            return quantity * (selectedCoin?.currentPrice ?? 0.0)
        }
        return 0.0
    }
    
    
    private var trailingToolBarItems : some View {
            HStack(spacing:0){
                
                Image(systemName:"checkmark")
                    .opacity(showPortfolio ? 1.0 : 0.0)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save")
                        .textCase(.uppercase)
                })
                .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(portfolioTextField) ? 1.0 : 0.0)
            } .font(.headline)
        
    }
    
    private func saveButtonPressed(){
        
        guard let coin = selectedCoin,
        let amount = Double(portfolioTextField)
                
        else { return }
        
        
        //save to Portfolio
//        print("\(coin.name) has \(amount) holdings")
        vm.updatePortfolioList(coin: coin, amount: amount)
        
        //show checkmark
        withAnimation(.easeIn){
            showPortfolio = true
            removeSelectedCoin()
        }
       
        
        //hide keyboard
        UIApplication.shared.endEditing()
        
        //hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut){
                showPortfolio = false
            }
        }
        
    }
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        
    }
    
    
}


    




#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.shared.vm)
}


