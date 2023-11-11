//
//  AppIntent.swift
//  Number
//
//  Created by W-Mai on 2023/11/12.
//

import WidgetKit
import AppIntents

enum ClockNumberType: String, AppEnum {
    case hour, minute, second, timestamp
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "显示类型"
    
    static var caseDisplayRepresentations: [ClockNumberType : DisplayRepresentation] = [
        .hour: "小时",
        .minute: "分钟",
        .second: "秒钟",
        .timestamp: "时间戳"
    ]
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "设置"
    static var description = IntentDescription("设置一下这个小组件的类型吧！")

    @Parameter(title: "显示类型", default: .hour)
    var type: ClockNumberType
    
    @Parameter(title: "是否显示数字类型", default: true)
    var showType: Bool
}
