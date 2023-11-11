//
//  Utils.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/12.
//

import Foundation

enum RandomType: String {
    case binary     = "'b"
    case octal      = "'o"
    case hex        = "'x"
    case decimal    = "'d"
    case roman      = "'r"
    case random     = "'?"
}

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

func getLocalTime(date: Date) -> DateComponents {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    
    let components = calendar.dateComponents([.hour, .minute, .second], from: date)
    
    return components
}

func choice<T>(_ arr: [T]) -> T {
    return arr.randomElement()!
}

func convertNum(num: Int, type: RandomType) -> String {
    switch type {
        
    case .binary:
        // convert to binary
        let binary = String(num, radix: 2)
        return binary
    case .octal:
        // convert to octal
        let octal = String(num, radix: 8)
        return octal
    case .hex:
        // conver to hex
        let hex = String(num, radix: 16)
        return hex
    case .decimal:
        return String(num)
    case .roman:
        // convert to roman
        let roman = convertToRoman(num)
        return roman
    case .random:
        // convert to random num
        let offset = Int.random(in: 0..<10)
        let random = num + offset
        return String(random)
    }
}
