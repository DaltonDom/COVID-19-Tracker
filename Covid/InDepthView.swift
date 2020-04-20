//
//  InDepthView.swift
//  Covid
//
//  Created by Dalton Domenighi on 4/12/20.
//  Copyright © 2020 Dalton Domenighi. All rights reserved.
//

import SwiftUI

struct InDepthView: View {
    @State var showList = false
    @State var pickerSelectedItem = 1
    @ObservedObject var data = GetDepthData()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("IN-DEPTH")
                    .font(.system(size: 30))
                    .bold()
                Text("Tracker")
                    .font(.system(size: 30))
                Spacer()
                Button(action: {
                    self.data.data = nil
                    self.data.updateData()
                }) {
                    Image(systemName: "goforward")
                        .foregroundColor(.primary)
                        .font(.system(size: 22))
                        .frame(width: 40, height: 40)
                        .background(Color("background3"))
                        .clipShape(Capsule())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            if self.data.data != nil{
                Text("Updated \(getMainDate(time: self.data.data.updated))")
                    .font(.caption)
                    .padding(.leading, 15)
                
            } else {
                GeometryReader{_ in
                    VStack {
                        Indicator()
                    }
                }
                .frame(height: 10)
            }
            if self.data.data != nil{
                Button(action: {
                    self.showList.toggle()
                    self.data.data = nil
                    self.data.updateData()
                }) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(self.data.whichCountry.uppercased())
                                .font(.system(size: 20)).bold()
                            Image("arrow-down-filled")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                }
                .accentColor(.primary)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .sheet(isPresented: $showList) {
                    ListOfCountriesView(whichCountry: self.$data.whichCountry)
                }
            } else {
                GeometryReader{_ in
                    VStack {
                        Indicator()
                    }
                }
                .frame(height: 10)
            }
            if self.data.data != nil{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CustomBorderView(color1: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), color2: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: data.data.cases), title: "Confirmed Cases", show: .constant(true))
                        CustomBorderView(color1: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: data.data.active), title: "Active Cases", show: .constant(true))
                        CustomBorderView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: data.data.deaths), title: "Deaths", show: .constant(true))
                        CustomBorderView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: data.data.critical), title: "Critical Condition", show: .constant(true))
                        CustomBorderView(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: data.data.tests), title: "Test Peformed", show: .constant(true))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .padding(.top, 15)
                    .padding(.leading, 10)
                }
            } else {
                GeometryReader{_ in
                    VStack {
                        Indicator()
                    }
                }
                .frame(height: 10)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("CHARTS")
                        .font(.system(size: 20))
                        .bold()
                    Text("- Daily")
                        .font(.system(size: 20))
                }
                Text("Every day for past two weeks")
                    .font(.caption)
                
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("Cases").tag(1) // New Cases for Daily(last three weeks)
                    Text("Deaths").tag(2) // New Deaths for Daily(last three weeks)
                    Text("Critical Condition").tag(3) // Progess bar or Chart for People in Critical Condition
                }.pickerStyle(SegmentedPickerStyle())
                
                if pickerSelectedItem == 1 {
                    ScrollView {
                        if self.data.data != nil{
                            VStack { //Cases
                                Group {
                                    BarView(dateString: "\(getDisplayDate(daysBack: -1))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -1))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -2))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -2))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -3))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -3))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -4))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -4))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -5))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -5))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -6))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -6))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -7))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -7))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -8))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -8))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -9))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -9))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -10))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -10))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                }
                                Group {
                                    BarView(dateString: "\(getDisplayDate(daysBack: -11))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -11))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -12))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -12))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -13))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -13))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -14))",dateValue: "\(self.data.countries.timeline.cases["\(getSpecificDate(daysBack: -14))"]!)",value: 70,color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                }
                            }
                        } else {
                            GeometryReader{_ in
                                VStack {
                                    Indicator()
                                }
                            }
                            .frame(height: 10)
                        }
                    }
                } else if pickerSelectedItem == 2 {
                    ScrollView {
                        if self.data.data != nil{
                            VStack { //Deaths
                                Group {
                                BarView(dateString: "\(getDisplayDate(daysBack: -1))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -1))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -2))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -2))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -3))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -3))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -4))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -4))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -5))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -5))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -6))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -6))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -7))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -7))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                 BarView(dateString: "\(getDisplayDate(daysBack: -8))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -8))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                 BarView(dateString: "\(getDisplayDate(daysBack: -9))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -9))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                 BarView(dateString: "\(getDisplayDate(daysBack: -10))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -10))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                }
                                Group {
                                    BarView(dateString: "\(getDisplayDate(daysBack: -11))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -11))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -12))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -12))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -13))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -13))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -14))",dateValue: "\(self.data.countries.timeline.deaths["\(getSpecificDate(daysBack: -14))"]!)",value: 40,color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                                }
                            }
                            //.frame(height: 290)
                        } else {
                            GeometryReader{_ in
                                VStack {
                                    Indicator()
                                }
                            }
                            .frame(height: 10)
                        }
                    }
                } else {
                    ScrollView {
                        if self.data.data != nil{
                            VStack { //Deaths
                                Group {
                                BarView(dateString: "\(getDisplayDate(daysBack: -1))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -1))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -2))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -2))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -3))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -3))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -4))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -4))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -5))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -5))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -6))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -6))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                BarView(dateString: "\(getDisplayDate(daysBack: -7))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -7))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                 BarView(dateString: "\(getDisplayDate(daysBack: -8))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -8))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                 BarView(dateString: "\(getDisplayDate(daysBack: -9))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -9))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                 BarView(dateString: "\(getDisplayDate(daysBack: -10))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -10))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                }
                                Group {
                                    BarView(dateString: "\(getDisplayDate(daysBack: -11))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -11))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -12))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -12))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -13))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -13))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                    BarView(dateString: "\(getDisplayDate(daysBack: -14))",dateValue: "\(self.data.countries.timeline.recovered["\(getSpecificDate(daysBack: -14))"]!)",value: 40,color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                }
                            }
                            //.frame(height: 290)
                        } else {
                            GeometryReader{_ in
                                VStack {
                                    Indicator()
                                }
                            }
                            .frame(height: 10)
                        }
                    }
                }
                ActiveCasesView()
            }
            .padding()
            Spacer()
            
        }
    }
}

struct InDepthView_Previews: PreviewProvider {
    static var previews: some View {
        InDepthView()
    }
}
func getMainDate(time: Double)->String {
    
    let date = Double(time / 1000)
    
    let format = DateFormatter()
    format.dateFormat = " hh:mm \n MMMM dd, YYYY"
    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
}


func getSpecificDate(daysBack: Int)->String {
    // Is to determine if the date is  one or two numbers
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yy"  // change formate as per your requirement
    
    let today = Date()
    let nextDate = Calendar.current.date(byAdding: .day, value: daysBack, to: today)
    let convertString = formatter.string(from: nextDate!)
    
    let date = formatter.date(from: convertString) //change "04/03/20" to your input string
    
    formatter.dateFormat = "M/d/yy"
    let dateString = formatter.string(from: date!)
    
    //print(dateString) // 4/3/20
    return dateString
}

func getDisplayDate(daysBack: Int)->String {
    // Is to determine if the date is  one or two numbers
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yy"  // change formate as per your requirement
    
    let today = Date()
    let nextDate = Calendar.current.date(byAdding: .day, value: daysBack, to: today)
    let convertString = formatter.string(from: nextDate!)
    
    let date = formatter.date(from: convertString) //change "04/03/20" to your input string
    
    formatter.dateFormat = "M/d"
    let dateString = formatter.string(from: date!)
    
    //print(dateString) // 4/3/20
    return dateString
}

func getProgressValue(value: String)->CGFloat {
    
    var newValue: CGFloat
    newValue = CGFloat((Double(value) ?? 0) * 0.000333)
    return newValue
}

struct CountryList: View {
    var body: some View {
        Text("list of countries")
    }
}

struct BarView: View {
    
    var dateString: String
    var dateValue: String
    var value: CGFloat
    var color1 = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    
    var body: some View {
        ZStack {
            Capsule().frame(width: UIScreen.main.bounds.width - 45, height: 34)
                .foregroundColor(Color.black.opacity(0.1))
            HStack {
                Text("\(dateString)")
                    .frame(width: 32)
                    .font(.system(size: 12))
                ZStack(alignment: .leading) {
                    Capsule().frame(width: 260, height: 15)
                        .foregroundColor(Color(color1).opacity(0.5))
                    Capsule().frame(width: getProgressValue(value: dateValue), height: 15)
                        .foregroundColor(Color(color1))
                }
                Spacer()
                Text("\(dateValue)")
                    .font(.system(size: 13))
            }
            .padding(.leading, 13)
            .padding(.trailing, 10)
            
        }
    }
}

struct CircleGraphView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    var width: CGFloat = 225
    var height: CGFloat = 225
    var percent: CGFloat = 4
    @Binding var show: Bool
    
    var body: some View {
        let multiplier = width / 44
        let progress = 1 - percent / 25
        
        return ZStack(alignment: .center) {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("TOTAL")
                        .font(.system(size: 16))
                        .bold()
                    Text("Cases - 124,124")
                        .font(.system(size: 15))
                }
                HStack {
                    Text("CRITICAL")
                        .font(.system(size: 15))
                        .bold()
                    Text("Cases - 124,124")
                        .font(.system(size: 15))
                }
                HStack(alignment: .center) {
                    Spacer()
                    Text("\(Int(percent))%")
                        .font(.system(size: 4 * multiplier))
                        .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .frame(width: 190)
        }
        .shadow(color: Color(color1).opacity(0.1), radius: 20, x: 0, y: 20)
        .frame(maxWidth: UIScreen.main.bounds.width - 20)
        .frame(height: 225)
        .padding(.top, 50)
    }
}

struct ActiveCasesView: View {
    
    @ObservedObject var data = GetDepthData()
    
    var body: some View {
        
        VStack(spacing: 10) {
            Text("Currently Infected Patients").bold()
            Divider()
            if self.data.data != nil{
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(Int(data.data.active - data.data.critical))")
                                .foregroundColor(Color.purple)
                            Text("\(String(format: "%.2f", Double(100 - (data.data.critical/data.data.cases) * 100)))%")
                        }
                        Text("Mild Conditions")
                    }
                    Divider()
                    VStack(alignment: .trailing) {
                        HStack {
                            Text(getValue(data: data.data.critical))
                                .foregroundColor(Color.red)
                            
                            Text("\(String(format: "%.2f", Double((data.data.critical/data.data.cases) * 100)))%")
                        }
                        Text("Critical Conditions")
                    }
                }
            } else {
                GeometryReader{_ in
                    VStack {
                        Indicator()
                    }
                }
                .frame(height: 10)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 20)
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}

struct Specific : Decodable {
    var cases : Double
    var active: Double
    var deaths: Double
    var critical: Double
    var tests: Double
    var updated: Double
}

struct HistoricalSpecific : Decodable {
    var country: String
    var timeline: Timeline
}

struct Timeline : Codable {
    var cases: [String: Int]
    var deaths: [String: Int]
    var recovered: [String: Int]
}

class GetDepthData: ObservableObject {
    
    @Published var data : Specific!
    @Published var countries : HistoricalSpecific!
    //var globalDatam: GlobalData
    @Published var whichCountry: String = "usa" {
        didSet {
            self.updateData()
        }
    }
    
    init() {
        updateData()
    }
    
    func updateData() {
        
        let url = "https://corona.lmao.ninja/v2/countries/" // specific country
        let url1 = "https://corona.lmao.ninja/v2/historical/"
        
        let session = URLSession(configuration: .default)
        let session1 = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url+"\(self.whichCountry)")!) { (data, _, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(Specific.self, from: data!)
            
            DispatchQueue.main.async {
                self.data = json
            }
            
        }.resume()
        
        session1.dataTask(with: URL(string: url1+"\(self.whichCountry)")!) { (data, _, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(HistoricalSpecific.self, from: data!)
            
            DispatchQueue.main.async {
                self.countries = json
            }
        }.resume()
    }
}
