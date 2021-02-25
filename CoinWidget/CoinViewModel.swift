//
//  CoinViewModel.swift
//  CoinWidgetExtension
//
//  Created by Eugene Shapovalov on 21.02.2021.
//

import Foundation

struct CoinViewModel: Hashable {
    var id = UUID()
    var coinName: String
    var coinPrice: String
    var coinSymbol: String
    
    init(model: Datum) {
        coinName = model.name
        coinPrice = "\(model.quote.usd.price)"
        coinSymbol = model.symbol
    }
    
    init(coinName: String, coinPrice: String, coinSymbol: String) {
        self.coinName = coinName
        self.coinPrice = coinPrice
        self.coinSymbol = coinSymbol
    }

}
