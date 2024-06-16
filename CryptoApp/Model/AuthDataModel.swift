//
//  AuthDataModel.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 02/06/2024.
//

import Foundation
import FirebaseAuth
struct AuthDataModel {
    
    let uid: String
    let email : String?
    let photoURL : String?
    
    
    init(user:User){
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
    
}
