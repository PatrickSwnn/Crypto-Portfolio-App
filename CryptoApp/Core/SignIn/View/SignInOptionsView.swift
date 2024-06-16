//
//  SignInOptionsView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 02/06/2024.
//

import SwiftUI

struct SignInOptionsView: View {
    var body: some View {
        VStack(spacing:15) {
            Text("Crypto App")
                .font(.headline)
                .fontWeight(.bold)
            NavigationLink {
                Text("Auth")
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .padding()
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
            }

        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        SignInOptionsView()
    }
}
