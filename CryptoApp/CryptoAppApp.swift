//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/04/2024.
//

import SwiftUI
import FirebaseCore

@main

struct CryptoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var authVM = SignInAndOutViewModel()
    @State var showLaunchScreen : Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor: UIColor(Color.theme.accent) ]
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor: UIColor(Color.theme.accent) ]
        UITableView.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    RootView()
                        .navigationBarBackButtonHidden(true)
                } .environmentObject(homeVM) //because of this, all the views, childs under HomeView will now be able to access home view model
                    .environmentObject(authVM)

                
            }
        }
        
        
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase Initialized")
        return true
    }
}
