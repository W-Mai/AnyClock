//
//  NumberView.swift
//  AnyClock
//
//  Created by W-Mai on 2023/11/12.
//

import SwiftUI

struct NumberView: View {
    var num: Int = 0
    
    var body: some View {
        Text(convertNum(num:num, index: Int.random(in: 1...5)))
            .foregroundStyle(.white)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .font(.custom("PixeloidSans-Bold", size: 200))
            .minimumScaleFactor(0.5)
    }
}

#Preview {
    NumberView()
}
