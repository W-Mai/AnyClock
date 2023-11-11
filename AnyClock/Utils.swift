//
//  Utils.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/12.
//

import Foundation

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

func convertNum(num: Int, index: Int) -> String {
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
