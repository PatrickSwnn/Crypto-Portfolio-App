//
//  AuthenticatoinViewModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 02/06/2024.
//

import Foundation
import FirebaseAuth
import Firebase
@MainActor
final class SignInAndOutViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    
    @Published var isSignedIn : Bool = false
    
    
    //    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //    let passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&+=]).{8,}"
    
    
    func signIn() {
        //        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        //        let passwordPredicate = NSPredicate(format : "SELF MATCHES %@", passwordRegex)
        guard  /*emailPredicate.evaluate(with: email) && */ !email.isEmpty, /*passwordPredicate.evaluate(with: password) && */ !password.isEmpty
        else { print("Sign In Validation Not passed")
            return }
        Task {
            do {
                let authResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
                    self.isSignedIn = true
                
                print("Auth Success")
                print(authResult)
            } catch {
                print("Error \(error)")
            }
        }
    }
    
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
            self.isSignedIn = false
        
        
        print("Sign Out Successful")
      
    }
    
    
}
