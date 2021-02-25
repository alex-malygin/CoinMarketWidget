//
//  CoinWidget.swift
//  CoinWidget
//
//  Created by Eugene Shapovalov on 21.02.2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry.getCoin()
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry.getCoin()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        CoinProvider.getCoinList { (coins, error) in
            let date = Date()
            let coins = coins?.data.map({CoinViewModel(model: $0)}) ?? []
            let entry = SimpleEntry(date: date, coins: coins)
            let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: date)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate ?? Date()))
            completion(timeline)
        }

    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var coins: [CoinViewModel]
    
    static func getCoin() -> SimpleEntry  {
        var coin = [CoinViewModel]()
        CoinProvider.getCoinList { (coins, error) in
            coin = coins?.data.map({CoinViewModel(model: $0)}) ?? []
        }
        return SimpleEntry(date: Date(), coins: coin)
    }
}

struct CoinWidgetEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        CoinWidgetSmall(coins: entry.coins)
    }
}

@main
struct CoinWidget: Widget {
    let kind: String = "CoinWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CoinWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("CoinMarketInfo")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CoinWidget_Previews: PreviewProvider {
    static var previews: some View {
        CoinWidgetEntryView(entry: SimpleEntry.getCoin())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
