//
//  CoinWidgetSmall.swift
//  CoinWidgetExtension
//
//  Created by Eugene Shapovalov on 21.02.2021.
//

import SwiftUI
import WidgetKit

struct CoinWidgetSmall: View {
    private var coins: [CoinViewModel]
    
    init(coins: [CoinViewModel]) {
        self.coins = coins
    }
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            ForEach(coins, id: \.self) { item in
                Spacer()
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(item.coinName)
                        Text(item.coinSymbol)
                    }
                    Text(item.coinPrice)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct CoinWidgetSmall_Previews: PreviewProvider {
    static var previews: some View {
        CoinWidgetSmall(coins: [CoinViewModel(coinName: "Bitcoin", coinPrice: "99000", coinSymbol: "BTC"),
                                CoinViewModel(coinName: "Bitcoin", coinPrice: "99000", coinSymbol: "BTC"),
                                CoinViewModel(coinName: "Bitcoin", coinPrice: "99000", coinSymbol: "BTC")
        ])
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
