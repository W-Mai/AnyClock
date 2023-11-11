//
//  SettingsView.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/12.
//

import SwiftUI

struct SettingsView: View {
    // Settings
    @AppStorage("HourShowType")     var hourShowType:   Bool = true
    @AppStorage("MinuteShowType")   var minuteShowType: Bool = true
    @AppStorage("SecondShowType")   var secondShowType: Bool = true
    @AppStorage("ShowSecond")       var showSecond:     Bool = true
    @AppStorage("ShowTimestamp")    var showTimestamp:  Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupBox("显示") {
                Toggle("是否显示秒钟", isOn: $showSecond)
                Toggle("是否显示时间戳", isOn: $showTimestamp)
            }
            GroupBox("展示数字类型") {
                Toggle("小时数字", isOn: $hourShowType)
                Toggle("分钟数字", isOn: $minuteShowType)
                Toggle("秒钟数字", isOn: $secondShowType)
            }
        }.padding()
    }
}

#Preview {
    SettingsView()
}
