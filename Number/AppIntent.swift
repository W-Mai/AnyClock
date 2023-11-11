//
//  AppIntent.swift
//  Number
//
//  Created by W-Mai on 2023/11/12.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "设置"
    static var description = IntentDescription("设置一下这个小组件的类型吧！")

    @Parameter(title: "显示类型", default: .hour)
    var type: ClockNumberType
    
    @Parameter(title: "是否显示数字类型", default: true)
    var showType: Bool
}
