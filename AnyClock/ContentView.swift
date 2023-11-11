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
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    let components = getLocalTime(date: currTime)
                    
                    let hour = components.hour!
                    let minute  = components.minute!
                    let sec  = components.second!
                    
                    NumberView(num: hour)
                    NumberView(num: minute)
                    NumberView(num: sec)
                }
                Text("\(currTime.timeIntervalSince1970)")
                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                        currTime = Date()
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
