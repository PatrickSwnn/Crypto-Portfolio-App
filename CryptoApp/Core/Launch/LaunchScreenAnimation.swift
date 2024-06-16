//
//  LaunchScreenAnimation.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 31/05/2024.
//

import SwiftUI

struct LaunchScreenAnimation: View {
    
    @State private var loadingText : [String] = "Loading your portfolio...".map{String($0)}
    @State private var showLoadingText : Bool = false
    
    @State private var counter : Int = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var loops : Int = 0
    @Binding  var showLaunchScreen : Bool
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            
            Image("logo")
                .resizable()
                .frame(width:100,height:100)
            HStack(spacing:0){
                ForEach(loadingText.indices){ index in
                    if showLoadingText {
                        Text(loadingText[index])
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.launch.accent)
                            .transition(AnyTransition.scale.animation(.easeIn))
                            .offset(y:counter == index ? -5 : 0)
                    }
                }
            }
            .offset(y:70)

        }
        .onAppear(perform: {
                showLoadingText.toggle()
            
        })
        .onReceive(timer, perform: { _ in
            withAnimation(.spring){
                let countdown = loadingText.count - 1
                if counter == countdown {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchScreen = false
                    }
                } else {
                    counter += 1
                }
            }
        })
        
    }
        
}

#Preview {
    LaunchScreenAnimation(showLaunchScreen: .constant(true))
}
