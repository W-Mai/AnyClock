//
//  NumberView.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/12.
//

import SwiftUI

struct NumberView: View {
    var num: Int = 0
    var type: RandomType = .binary
    var showType: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack {
                Text(convertNum(num:num, type: type))
                    .foregroundStyle(.primary)
//                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .font(.custom("PixeloidSans-Bold", size: 200))
            }
            .padding(8)
            
            if showType {
                Text("\(type.rawValue)")
                    .foregroundStyle(.gray)
                    .font(.custom("PixeloidSans-Bold", size: 16))
                    .minimumScaleFactor(0.05)
            }
        }
//        .aspectRatio(1, contentMode: .fill)
    }
}

#Preview {
    NumberView()
}
