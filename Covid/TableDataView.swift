//
//  TableDataView.swift
//  Covid
//
//  Created by Dalton Domenighi on 4/12/20.
//  Copyright © 2020 Dalton Domenighi. All rights reserved.
//

import SwiftUI

struct TableDataView: View {
    @ObservedObject var data = getData()
    var countryName: String = "Germany"
    var countryActiveCases: String = "123,445"
    var countryDeaths: String = "2,000"
    
    var width: CGFloat = UIScreen.main.bounds.width - 30
    var height: CGFloat = UIScreen.main.bounds.height - 90
    
    var body: some View {
        let multiplier = width / 77
        
        return ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: multiplier))
                .frame(width: width, height: height / 2)
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: multiplier))
                .frame(width: width, height: 50)
                .padding(.top, 50)
            Text("Top Countries").bold()
                .padding(.top, 15)
            HStack {
                Text("Country").bold()
                Spacer()
                Text("Active Cases")
                    .font(.caption)
                Text("|")
                    .font(.caption)
                Text("Deaths")
                    .font(.caption)
            }
            .padding(.top, 100)
            .frame(width: width - 30, height: 50)
            
            ScrollView(showsIndicators: false) {
                if self.data.countries.count != 0 && self.data.data != nil{
                    VStack(alignment: .leading) {
                        ForEach(self.data.countries.sorted { $0.cases > $1.cases}, id: \.self) { i in
                            CountryListView(data: i)
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
            .padding(.top, 120)
        }
        .frame(maxHeight: UIScreen.main.bounds.height / 3)
    }
}

struct TableDataView_Previews: PreviewProvider {
    static var previews: some View {
        TableDataView()
    }
}

struct CountryListView: View {
    
    var data: Details
    
    var body: some View {
        VStack {
            HStack {
                Text(data.country)
                    .frame(width: 100)
                Spacer()
                Text(getValue(data: data.cases) + "  ")
                    .frame(width: 70)
                Divider()
                Text(getValue(data: data.deaths))
                    .frame(width: 65)
            }
            
            Divider()
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
    }
}

