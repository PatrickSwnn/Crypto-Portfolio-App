//
//  EmailSignInView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 02/06/2024.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct EmailSignInView: View {
 
    @EnvironmentObject  var authVM : SignInAndOutViewModel
    var body: some View {
        VStack(spacing:10){
            
            TextField(text: $authVM.email) {
                Text("Email")
              
            }
            .padding()
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
            .padding()
            SecureField(text: $authVM.password) {
                Text("Password")
                   
            }
            .padding()
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
            .padding()
            
            Button {
                authVM.signIn()
            } label : {
                Text("Sign In")
                    .font(.headline)
                    .padding()
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            
            
            
            
            
        }
       

        
        .navigationTitle("Email Sign In")
    }
}

//#Preview {
//    NavigationStack {
//        EmailSignInView(authVM: authV<)
//
//    }
//}
