//
//  CoinViewModel.swift
//  CoinWidgetExtension
//
//  Created by Eugene Shapovalov on 21.02.2021.
//

import Foundation

enum CoinState: String {
    case up
    case down
}

struct CoinViewModel: Hashable {
    var id = UUID()
    var coinName: String
    var coinPrice: String
    var coinSymbol: String
    var state: CoinState
    
    init(model: Datum) {
        coinName = model.name
        coinPrice = "$\(model.quote.usd.price.formattedWithSeparator)"
        coinSymbol = model.symbol
        state = model.quote.usd.percentChange1H > 0 ? .up : .down
        
    }
    
    init(coinName: String, coinPrice: String, coinSymbol: String) {
        self.coinName = coinName
        self.coinPrice = coinPrice
        self.coinSymbol = coinSymbol
        self.state = .up
    }

}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
