//
//  Number.swift
//  Number
//
//  Created by W-Mai on 2023/11/12.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 3600 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct NumberEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        let component = getLocalTime(date: entry.date)
        
        VStack {
            if family == .systemSmall 
                || family == .accessoryInline{
                switch entry.configuration.type {
                case .hour:
                    NumberView(num: component.hour!, showType: entry.configuration.showType)
                case .minute:
                    NumberView(num: component.minute!, showType: entry.configuration.showType)
                case .second:
                    NumberView(num: component.second!, showType: entry.configuration.showType)
                case .timestamp:
                    NumberView(num: Int(entry.date.timeIntervalSince1970) as Int, showType: entry.configuration.showType)
                }
            } else if family == .systemMedium 
                        || family ==  .systemLarge
                        || family == .systemExtraLarge
                        || family == .accessoryRectangular {
                HStack {
                    NumberView(num: component.hour!, showType: true)
                    NumberView(num: component.minute!, showType: true)
                }
            }
            
        }.padding(8)
            .minimumScaleFactor(0.05)
        
    }
}

struct Number: Widget {
    let kind: String = "Number"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            NumberEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var hour: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.type = .hour
        return intent
    }
    
    fileprivate static var minute: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.type = .minute
        return intent
    }    
    
    fileprivate static var second: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.type = .minute
        return intent
    }    
    
    fileprivate static var timestamp: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.type = .minute
        return intent
    }
}

#Preview(as: .systemSmall) {
    Number()
} timeline: {
    SimpleEntry(date: .now, configuration: .hour)
    SimpleEntry(date: .now, configuration: .minute)
    SimpleEntry(date: .now, configuration: .second)
    SimpleEntry(date: .now, configuration: .timestamp)
}
