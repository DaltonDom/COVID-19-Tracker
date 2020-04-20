//
//  ListOfCountriesView.swift
//  Covid
//
//  Created by Dalton Domenighi on 4/14/20.
//  Copyright © 2020 Dalton Domenighi. All rights reserved.
//

import SwiftUI

struct ListOfCountriesView: View {
    
    @Binding var whichCountry: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("List of Countries".uppercased())
                
                    .bold()
                    .padding(.top, 25)
                ForEach(0 ..< countriesListData.count) { i in
                    Button(action: {
                        self.whichCountry = countriesListData[i]
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack {
                            Text("\(countriesListData[i].uppercased())")
                                .font(.system(size: 25))
                                .foregroundColor(Color.white)
                            Divider()
                        }
                        .background(RadialGradient(gradient: Gradient(colors: [Color.green, Color.blue]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/))
                        .cornerRadius(15)
                        .shadow(color: Color.green.opacity(0.3), radius: 20, x: 0, y: 20)
                    }
                    .frame(width: 240)
                }
            }
        }
    }
}
struct ListOfCountriesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCountriesView(whichCountry: .constant("USA"))
    }
}

var countriesListData: [String] = ["usa", "spain", "italy", "france", "germany", "uk", "china", "iran", "turkey", "belgium", "netherlands", "canada", "switzerland", "brazil", "russia", "portugal", "austria", "israel", "india", "ireland", "sweden", "S. Korea",
    "peru", "japan", "chile", "ecuador", "poland", "romania", "normay", "denmark",
    "australia", "czechia", "pakistan", "mexico", "South Africa"]
