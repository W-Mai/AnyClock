//
//  ContentView.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/11.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var currTime: Date = Date()
    
    @State var hourType:   RandomType = .decimal
    @State var minuteType: RandomType = .decimal
    @State var secondType: RandomType = .decimal
    
    @State var hourTypeNeedChange:   Bool = false
    @State var minuteTypeNeedChange: Bool = false
    @State var secondTypeNeedChange: Bool = false
    
    @State var preHour:   Int = 0
    @State var preMinute: Int = 0
    @State var preSecond: Int = 0
    
    @State var hour:   Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    
    @State var settingViewShow: Bool = false
    
    // Settings
    @AppStorage("HourShowType")     var hourShowType:   Bool = true
    @AppStorage("MinuteShowType")   var minuteShowType: Bool = true
    @AppStorage("SecondShowType")   var secondShowType: Bool = true
    @AppStorage("ShowSecond")       var showSecond:     Bool = true
    @AppStorage("ShowTimestamp")    var showTimestamp:  Bool = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    NumberView(num: hour,
                               type: hourType,
                               showType: hourShowType)
                    .onTapGesture {
                        hourTypeNeedChange = true
                    }
                    .onLongPressGesture {
                        hourShowType.toggle()
                    }
                    
                    NumberView(num: minute,
                               type: minuteType,
                               showType: minuteShowType)
                    .onTapGesture {
                        minuteTypeNeedChange = true
                    }
                    .onLongPressGesture {
                        minuteShowType.toggle()
                    }
                    
                    if showSecond {
                        NumberView(num: second,
                                   type: secondType,
                                   showType: secondShowType)
                        .onTapGesture {
                            secondTypeNeedChange = true
                        }
                        .onLongPressGesture {
                            secondShowType.toggle()
                        }
                    }
                }
                .minimumScaleFactor(0.05)
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                    currTime = Date()
                    
                    let components = getLocalTime(date: currTime)
                    
                    hour    = components.hour!
                    minute  = components.minute!
                    second  = components.second!
                    
                    if hourTypeNeedChange || hour != preHour {
                        hourType = choice([.decimal, .hex, .octal, .roman])
                        hourTypeNeedChange = false
                    }
                    
                    if minuteTypeNeedChange || minute != preMinute {
                        minuteType = choice([.decimal, .hex, .octal, .roman])
                        minuteTypeNeedChange = false
                    }
                    
                    if secondTypeNeedChange || second != preSecond {
                        secondType = choice([.decimal, .hex, .octal, .roman, .random, .binary])
                        secondTypeNeedChange = false
                    }
                    
                    preHour = hour
                    preMinute = minute
                    preSecond = second
                }
                
                if showTimestamp {
                    Text("\(currTime.timeIntervalSince1970)")
                        .foregroundStyle(.white)
                        .font(.custom("PixeloidSans-Bold", size: 20))
                }
            }.sheet(isPresented: $settingViewShow, content: {
                SettingsView()
            })
        }
        .onTapGesture(count: 2, perform: {
            showSecond.toggle()
        })
        .onLongPressGesture {
            settingViewShow = true
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
