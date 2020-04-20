//
//  TabBarView.swift
//  Covid
//
//  Created by Dalton Domenighi on 4/12/20.
//  Copyright © 2020 Dalton Domenighi. All rights reserved.
//

import SwiftUI
import UIKit

struct TabBarView: View {
    @State var selectedItem = 1
    
    
    var body: some View {
        TabView(selection: $selectedItem) {
            //Home
            ContentView().tabItem {
                Image(systemName: "house.fill")
                    .font(.system(size: 20, weight: .medium))
                Text("Home")
            }.tag(1)
            //In-depth by Specific
            InDepthView().tabItem {
                Image(systemName: "magnifyingglass.circle")
                    .font(.system(size: 20, weight: .medium))
                Text("In-Depth")
            }.tag(2)
            //Contact Tracing
          /*  ContactTracingView().tabItem {
                Image(systemName: "map")
                    .font(.system(size: 20, weight: .medium))
                Text("Contact Tracing")
            }.tag(3)  */
        }
        .accentColor(Color.blue)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(GlobalData())
    }
}
