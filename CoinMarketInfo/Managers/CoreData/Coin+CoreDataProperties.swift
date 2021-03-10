//
//  Coin+CoreDataProperties.swift
//  CoinMarketInfo
//
//  Created by Eugene Shapovalov on 09.03.2021.
//
//

import Foundation
import CoreData


extension Coin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coin> {
        return NSFetchRequest<Coin>(entityName: "Coin")
    }

    @NSManaged public var price: Double
    @NSManaged public var symbol: String?
    @NSManaged public var name: String?
    @NSManaged public var state: Int32

}

extension Coin : Identifiable {

}
