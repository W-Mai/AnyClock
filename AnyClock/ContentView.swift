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
    
    @State var preHour:   Int = 0
    @State var preMinute: Int = 0
    @State var preSecond: Int = 0
    
    @State var hour:   Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    NumberView(num: hour,
                               type: hourType,
                               showType: true)
                    NumberView(num: minute,
                               type: minuteType,
                               showType: true)
                    NumberView(num: second,
                               type: secondType,
                               showType: true)
                }
                .minimumScaleFactor(0.05)
                Text("\(currTime.timeIntervalSince1970)")
                    .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                        currTime = Date()
                        
                        let components = getLocalTime(date: currTime)
                        
                        hour    = components.hour!
                        minute  = components.minute!
                        second  = components.second!
                        
                        if hour != preHour {
                            hourType = choice([.decimal, .hex, .octal, .roman])
                        }
                        
                        if minute != preMinute {
                            minuteType = choice([.decimal, .hex, .octal, .roman])
                        }
                        
                        if second != preSecond {
                            secondType = choice([.decimal, .hex, .octal, .roman, .random, .binary])
                        }
                        
                        preHour = hour
                        preMinute = minute
                        preSecond = second
                    }
                    .foregroundStyle(.white)
                    .font(.custom("PixeloidSans-Bold", size: 20))
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
