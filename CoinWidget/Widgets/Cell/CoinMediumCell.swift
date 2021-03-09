//
//  CoinMediumCell.swift
//  CoinWidgetExtension
//
//  Created by Eugene Shapovalov on 28.02.2021.
//

import SwiftUI
import WidgetKit

struct CoinMediumCell: View {
    private var coins: CoinViewModel
    
    init(coins: CoinViewModel) {
        self.coins = coins
    }
    
    var body: some View {
        VStack {
            HStack() {
                VStack(alignment: .leading) {
                    Text(coins.coinName)
                        .font(.system(size: 12))
                        .fontWeight(.black)
                    Text(coins.coinSymbol)
                        .font(.system(size: 12))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                switch coins.state {
                    case .up:
                        Text(coins.coinPrice)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    case .down:
                        Text(coins.coinPrice)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                        
                }
                
            }
            .padding(2)
            .frame(maxWidth: .infinity)
            .padding(.leading, 12)
            .padding(.trailing, 12)
            Divider()
        }
    }
}

struct CoinMediumCell_Previews: PreviewProvider {
    static var previews: some View {
        CoinMediumCell(coins: CoinViewModel(coinName: "Bitcoin", coinPrice: "99000", coinSymbol: "BTC")
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
