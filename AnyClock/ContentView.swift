//
//  ContentView.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/11.
//

import SwiftUI
import SwiftData

func convertToRoman(_ number: Int) -> String {
    let romanValues: [(value: Int, symbol: String)] = [
        (1000, "M"),
        (900, "CM"),
        (500, "D"),
        (400, "CD"),
        (100, "C"),
        (90, "XC"),
        (50, "L"),
        (40, "XL"),
        (10, "X"),
        (9, "IX"),
        (5, "V"),
        (4, "IV"),
        (1, "I")
    ]
    
    var result = ""
    var remainingValue = number
    
    for romanValue in romanValues {
        let count = remainingValue / romanValue.value
        if count > 0 {
            for _ in 0..<count {
                result += romanValue.symbol
                remainingValue -= romanValue.value
            }
        }
    }
    
    return result
}

func random_trans_number(num: Int, index: Int) -> String {
    switch index {
    case 0:
        // convert to binary
        let binary = String(num, radix: 2)
        return binary
    case 1:
        // convert to octal
        let octal = String(num, radix: 8)
        return octal
    case 2:
        // conver to hex
        let hex = String(num, radix: 16)
        return hex
    case 3:
        return String(num)
    case 4:
        // convert to random num
        let offset = Int.random(in: 0..<10)
        let random = num + offset
        return String(random)
    case 5:
        // convert to roman
        let roman = convertToRoman(num)
        return roman
    default:
        return ""
    }
}

var pre_hour = 0
var pre_min  = 0
var pre_sec  = 0

var pre_hour_transed = ""
var pre_min_transed  = ""
var pre_sec_transed  = ""

class TimeFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        guard let date = obj as? Date else { return nil }
        
        // get hour, min, sec
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        let hour = components.hour!
        let minute  = components.minute!
        let sec  = components.second!
        
        if hour ^ pre_hour != 0 {
            pre_hour_transed = random_trans_number(num: hour, index: Int.random(in: 1..<6))
        }
        
        if minute ^ pre_min != 0 {
            pre_min_transed = random_trans_number(num: minute, index: Int.random(in: 1..<6))
        }
        
        if sec ^ pre_sec != 0 {
            pre_sec_transed = random_trans_number(num: sec, index: Int.random(in: 1..<6))
        }
        
        pre_hour = hour
        pre_min  = minute
        pre_sec  = sec
        
        return "\(pre_hour_transed):\(pre_min_transed):\(pre_sec_transed)"
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var currTime: Date = Date()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text(currTime, formatter: TimeFormatter())
                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                        // update current time
                        currTime = Date()
                    }
                    .foregroundStyle(.white)
                    .font(.custom("PixeloidSans-Bold", size: 200))
                    .minimumScaleFactor(0.5)
                Text("\(currTime.timeIntervalSince1970)")
                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                        // update current time
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
