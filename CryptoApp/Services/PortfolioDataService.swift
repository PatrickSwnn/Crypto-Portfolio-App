//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 14/05/2024.
//

import Foundation
import CoreData


class PortfolioDataService {
    
    let container : NSPersistentContainer
    let containerName : String = "PortfolioContainer"
    let entityName : String = "Portfolio"
    @Published var savedEntities : [Portfolio] = []
    //initialize the container
    init(){
        container = NSPersistentContainer(name:containerName)
        //load all stores from container
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data.\(error.localizedDescription)")
            }
        }
        self.getPortfolio()
    }
    
    

    // MARK: CRUD Funcs
    private func getPortfolio(){
        //make NSFetchRequest
        let request = NSFetchRequest<Portfolio>(entityName: entityName) // since NSFR can be generic, add the expected type to return with <>
        do {
            savedEntities = try  container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching data from Core Data \(error.localizedDescription)")
        }
    }
    
    
    private func addPortfolio(coin:CoinModel,amount:Double){
        //initialize a new entity and put it in the viewContext
        let entity = Portfolio(context: container.viewContext)
        //map it
        entity.coinID = coin.id
        entity.amount = amount
        //apply changes
        applyChanges()
    }
     //since we already have the created entity
    private func updatePortfolio(entity:Portfolio,amount:Double){
        entity.amount = amount
        print("Update Portfolio is being executed")
        applyChanges()
    }
    
    private func deletePortfolio(entity:Portfolio){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveChanges(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving the data into Core Data\(error.localizedDescription)")
        }
    }
    
    private func applyChanges(){
        saveChanges()
        getPortfolio()
        //saving and refreshing
    }
    
    // MARK: Public Func for Making UI Efficient Code
    
    //this func will decide whether it should add, update or delete the Portfolio Coins
    func refreshPortfolio(coin:CoinModel,amount:Double) {
        //check whether the coin exists in the Portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            //if exist, we will update or delete
            if amount > 0 {
                //we will update it if it > 0
                updatePortfolio(entity: entity, amount: amount)
            } else {
                //we will remove
                deletePortfolio(entity: entity)
            }
        } else {
            //if not exist, we will add
            addPortfolio(coin: coin, amount: amount)
        }
        
    }
    
    
    
}
