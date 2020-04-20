//
//  CustomBorderView.swift
//  Covid
//
//  Created by Dalton Domenighi on 4/12/20.
//  Copyright © 2020 Dalton Domenighi. All rights reserved.
//

import SwiftUI

struct CustomBorderView: View {
    var color1 = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    var color2 = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    var width: CGFloat = 130
    var height: CGFloat = 130
    var percent: CGFloat = 7
    var number: String = "20,6089"
    var title: String = "Confirmed Cases"
    @Binding var show: Bool
    
    
    var body: some View {
        let multiplier = width / 44
        //let progress = 1 - percent / 100
        
        return ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: multiplier))
                .frame(width: width, height: height)
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .trim(from: show ? 0.81 : 1, to: 0.90)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .leading, endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 2 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0))
                .frame(width: width, height: height)
            VStack(alignment: .leading, spacing: 20) {
                Text("\(number)")
                    .font(.system(size: 8 * multiplier))
                    .fontWeight(.bold)
                    .foregroundColor(Color(color1))
                Text("\(title)")
                    .font(.system(size: 4 * multiplier))
                    .fontWeight(.bold)
                    .lineLimit(2)
            }
        }
    }
}

struct CustomBorderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBorderView(show: .constant(true))
    }
}
