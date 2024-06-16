//
//  AuthenticationManager.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 02/06/2024.
//

import Foundation
import FirebaseAuth


final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init(){}
    
    
    func createUser(email:String,password:String) async throws -> AuthDataModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataModel(user: authDataResult.user)
    }
    
    func getUser() throws -> AuthDataModel { //this is not gonna be async func because this will be done locally without needing to communicate the server
        // and also we don't use async because this has to be synchronous. i.e, you can't use an app skipping the step of checking if the user already exists or not
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
       return AuthDataModel(user: user)
        
    }
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
    
    
}
/*
 
 Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
   guard let strongSelf = self else { return }
   // ...
 }
 */
