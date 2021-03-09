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
        SimpleEntry(date: Date(), coins: [
                        CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                        CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                        CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "...")])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), coins: [
                                    CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                                    CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                                    CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "...")])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        CoinProvider.getCoinList { (coin, error) in
            let date = Date()
            let coins = coin?.data.map({CoinViewModel(model: $0)}) ?? []
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
}

struct CoinWidgetEntryView : View {
    var entry: SimpleEntry

    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall:
                CoinWidgetSmall(coins: entry.coins)
            case .systemMedium:
                CoinWidgetMedium(coins: entry.coins)
            case .systemLarge:
                CoinWidgetLarge(coins: entry.coins)
            default:
                CoinWidgetSmall(coins: entry.coins)
        }
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
        Group {
            CoinWidgetEntryView(entry: SimpleEntry(date: Date(), coins: [
                                                                CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                                                                CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                                                                CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "...")]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
            CoinWidgetEntryView(entry: SimpleEntry(date: Date(), coins: [
                                                    CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                                                    CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "..."),
                                                    CoinViewModel(coinName: "...", coinPrice: "...", coinSymbol: "...")]))
            .redacted(reason: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
