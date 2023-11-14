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
        
        switch configuration.type {
        case .hour:
            for ofs in 0 ..< 3 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        case .minute:
            for ofs in 0 ..< 180 {
                let entryDate = Calendar.current.date(byAdding: .minute, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        case .second:
            for ofs in 0 ..< 360 {
                let entryDate = Calendar.current.date(byAdding: .second, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        case .timestamp:
            for ofs in 0 ..< 360 {
                let entryDate = Calendar.current.date(byAdding: .second, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        case .hourminute:
            for ofs in 0 ..< 180 {
                let entryDate = Calendar.current.date(byAdding: .minute, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        case .minutesecond:
            for ofs in 0 ..< 360 {
                let entryDate = Calendar.current.date(byAdding: .second, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        case .hourminutesecond:
            for ofs in 0 ..< 360 {
                let entryDate = Calendar.current.date(byAdding: .second, value: ofs, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
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
            switch entry.configuration.type {
            case .hour:
                NumberView(num: component.hour!,
                           type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .hour),
                           showType: entry.configuration.showType)
            case .minute:
                NumberView(num: component.minute!,
                           type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                           showType: entry.configuration.showType)
            case .second:
                NumberView(num: component.second!,
                           type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .second),
                           showType: entry.configuration.showType)
            case .timestamp:
                NumberView(num: Int(entry.date.timeIntervalSince1970) as Int,
                           type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .timestamp),
                           showType: entry.configuration.showType)
            case .hourminute:
                if family == .systemSmall
                    || family == .accessoryInline{
                    VStack {
                        NumberView(num: component.hour!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .hour),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.minute!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                                   showType: entry.configuration.showType)
                    }
                } else {
                    HStack {
                        NumberView(num: component.hour!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .hour),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.minute!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                                   showType: entry.configuration.showType)
                    }
                }
            case .minutesecond:
                if family == .systemSmall
                    || family == .accessoryInline{
                    VStack {
                        NumberView(num: component.minute!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.second!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .second),
                                   showType: entry.configuration.showType)
                    }
                } else {
                    HStack {
                        NumberView(num: component.minute!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.second!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .second),
                                   showType: entry.configuration.showType)
                    }
                }
            case .hourminutesecond:
                if family == .systemSmall
                    || family == .accessoryInline{
                    VStack {
                        NumberView(num: component.hour!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .hour),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.minute!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.second!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .second),
                                   showType: entry.configuration.showType)
                    }
                } else {
                    HStack {
                        NumberView(num: component.hour!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .hour),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.minute!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .minute),
                                   showType: entry.configuration.showType)
                        NumberView(num: component.second!,
                                   type: getRandomNumberTpyeByTimestamp(date: entry.date, type: .second),
                                   showType: entry.configuration.showType)
                    }
                }
            }
        }
        .padding(8)
        .minimumScaleFactor(0.05)
    }
}

struct Number: Widget {
    @Environment(\.widgetFamily) var family: WidgetFamily
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
