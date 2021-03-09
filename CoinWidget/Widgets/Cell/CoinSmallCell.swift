//
//  CoinSmallCell.swift
//  CoinWidgetExtension
//
//  Created by Eugene Shapovalov on 27.02.2021.
//

import SwiftUI
import WidgetKit

struct CoinSmallCell: View {
    
    private var coins: CoinViewModel
    @State var containedViewType: CoinState = .up
    
    init(coins: CoinViewModel) {
        self.coins = coins
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            HStack() {
                VStack(alignment: .leading) {
                    Text(coins.coinName)
                        .font(.system(size: 10))
                        .fontWeight(.black)
                    Text(coins.coinSymbol)
                        .font(.system(size: 8))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                Spacer()
            
                switch coins.state {
                    case .up:
                        Text(coins.coinPrice)
                            .font(.system(size: 10))
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    case .down:
                        Text(coins.coinPrice)
                            .font(.system(size: 10))
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                        
                }
                
            }
            .padding(3)
            .frame(maxWidth: .infinity)
            .padding(.leading, 5)
            .padding(.trailing, 5)
            Divider()
        }
    }
}

struct CoinSmallCell_Previews: PreviewProvider {
    static var previews: some View {
            CoinSmallCell(coins: CoinViewModel(coinName: "Bitcoin", coinPrice: "99000", coinSymbol: "BTC")
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
