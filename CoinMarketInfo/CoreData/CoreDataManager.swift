//
//  CoreDataManager.swift
//  CoinMarketInfo
//
//  Created by Eugene Shapovalov on 09.03.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoinModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    func saveCoins(_ coins: CoinData) {
        coins.data.forEach{self.saveOrUpdateCoin($0)}
        saveContext()
    }
    
    func saveOrUpdateCoin(_ coins: Datum) {
        if !updateCoin(coins) {
            makeManadgedObjectCoin(coins)
        }
    }
    
    func updateCoin(_ coinData: Datum) -> Bool {
        
        let fetchRequest = NSFetchRequest<Coin>(entityName: "Coin")
        
//        let predicate = NSPredicate(format: "name = %@", coinData.name)
//        fetchRequest.predicate = predicate
        
        guard let coin = try? context.fetch(fetchRequest).first else { return false }
        
        coin.name = coinData.name
        coin.symbol = coinData.symbol
        coin.price = coinData.quote.usd.price
        coin.state = Int32(coinData.quote.usd.percentChange1H)
        
        return true
    }
    
    @discardableResult func makeManadgedObjectCoin(_ coins: Datum) -> NSManagedObject {
    let coin = Coin(context: context)
        coin.name = coins.name
        coin.price = coins.quote.usd.price
        coin.symbol = coins.symbol
        coin.state = Int32(coins.quote.usd.percentChange1H)
        return coin
    }
}
