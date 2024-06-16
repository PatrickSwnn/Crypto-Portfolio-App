//
//  SettingView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 31/05/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct SettingView: View {
    
    @State private var cokinGeckoURL = URL(string: "https://www.coingecko.com/")!
    @State private var nickURL = URL(string:"https://www.youtube.com/@SwiftfulThinking")!
    @State private var myGitHub = URL(string: "https://github.com/PatrickSwnn")!
    @EnvironmentObject var authVM : SignInAndOutViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                //background layer
                Color.theme.background
                    .ignoresSafeArea(.all)
                
                //content layer
                List {
                    appReferenceSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    myPortfolio
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    privacySection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                  
                }
            }
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkView()
                }
            }
            
        }
        .scrollContentBackground(.hidden)

       
    }
}



extension SettingView {
    private var appReferenceSection : some View {
        Section {
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                    .frame(width:100,height:100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is a modified app referencing the crypto app by Nick of Swiftful Thinking.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(destination: nickURL) {
                Text("Swiftul Thinking")
                    .font(.headline)
                    .tint(.blue)
            }
        } header: {
            Text("App Reference")
        }
    }
    
    private var coinGeckoSection : some View {
    
            Section {
                VStack(alignment:.leading){
                    Image("coingecko")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height:100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("This is the free api used for this app.It might have a slight delay in price updates")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.theme.accent)
                }
                .padding(.vertical)
                Link(destination: cokinGeckoURL) {
                    Text("Coin Gecko")
                        .font(.headline)
                        .tint(.blue)
                }
            } header: {
                Text("CoinGecko API")
            }
        }
    
    
    
    private var myPortfolio : some View {
    
            Section {
                VStack(alignment:.leading){
                    Image("github")
                        .resizable()
                        .frame(width:100,height:100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("This is my github URL")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.theme.accent)
                }
                .padding(.vertical)
                Link(destination: myGitHub) {
                    Text("GitHub URL")
                        .font(.headline)
                        .tint(.blue)
                }
            } header: {
                Text("My Portfolio")
            }
        }
    
    
    private var privacySection : some View {
        
        Section {
            Link(destination: URL(string: "www.google.com")!) {
                Text("Privacy Policy")
                    .font(.headline)
                    .tint(.blue)
                
            }
            Link(destination: URL(string: "www.google.com")!) {
                Text("Terms of Use")
                    .font(.headline)
                    .tint(.blue)
                
            }
            Button {
                Task {
                    do {
                        try authVM.signOut()
                    } catch {
                        print("error due to \(error.localizedDescription)")
                    }
                }
                    
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .tint(.red)
            }
            
            
        }
    }
    
    
    
}

//
//#Preview {
//        SettingView()
//    
//}
