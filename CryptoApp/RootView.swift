//
//  RootView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 02/06/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject  var authVM : SignInAndOutViewModel
    var body: some View {
//        ZStack {
//            NavigationStack {
//                HomeView()
//            }
//            .onAppear {
//               
//                    let existingUser = try? AuthenticationManager.shared.getUser()
//                //since the tinary operator returns bool values, we don't need to add ? and :
//                    showSignInView = (existingUser == nil)
//               
//            }
//        }
//        .fullScreenCover(isPresented: $showSignInView, content: {
//            EmailSignInView()
//        })
        
        
        ZStack {
            if authVM.isSignedIn {
                HomeView()
                    .transition(.move(edge: .leading))
            } else {
                EmailSignInView()
                    .transition(.move(edge: .leading))
            }
        }
        .onAppear{
            let existingUser = try? AuthenticationManager.shared.getUser()
           //                //since the tinary operator returns bool values, we don't need to add ? and :
            authVM.isSignedIn = (existingUser != nil)
        }

    }
}

//#Preview {
//    RootView()
//        .environmentObject(e)
//}
