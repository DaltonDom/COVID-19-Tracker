//
//  ContentView.swift
//  Covid
//
//  Created by Dalton Domenighi on 4/11/20.
//  Copyright © 2020 Dalton Domenighi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var data = getData()
    
    var body: some View {
        
        VStack {
            HStack {
                HStack {
                    Text("COVID-19")
                        .font(.system(size: 30))
                        .font(.headline).bold()
                    Text("Stats")
                        .font(.system(size: 30))
                }
                Spacer()
                // Refresh the feed
                Button(action: {
                    self.data.data = nil
                    self.data.countries.removeAll()
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
            .padding(.leading, 30)
            .padding(.trailing, 30)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("GLOBAL")
                            .font(.system(size: 25))
                            .bold()
                        Text("Statistics")
                            .font(.system(size: 23))
                    }
                    .padding()
                    Spacer()
                    if self.data.countries.count != 0 && self.data.data != nil{
                        VStack(alignment: .trailing) {
                            Text("Updated\(getDate(time: self.data.data.updated))")
                                .frame(width: 110)
                                .font(.system(size: 13))
                                .lineLimit(3)
                        }
                    }
                    else {
                        GeometryReader{_ in
                            VStack {
                                Indicator()
                            }
                        }
                        .frame(height: 10)
                    }
                }
                GlobalCasesView()
                
                VStack {
                    VStack {
                       TableDataView()
                    }
                    .padding(.top, 70)
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalData())
            //.environment(\.colorScheme, .dark)
    }
}

struct GlobalCasesView: View {
    
    @ObservedObject var data = getData()
    
    var body: some View {
        VStack {
            Spacer()
            if self.data.countries.count != 0 && self.data.data != nil {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CustomBorderView(color1: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), color2: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: self.data.data.cases), title: "Confirmed Cases", show: .constant(true))
                        CustomBorderView(color1: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: self.data.data.active), title: "Active Cases", show: .constant(true))
                        CustomBorderView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 130, height: 130, percent: 24, number: getValue(data: self.data.data.deaths), title: "Deaths", show: .constant(true))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .padding(.leading, 10)
                }
            }
            else {
                GeometryReader{_ in
                    VStack {
                        Indicator()
                    }
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width,height: 150)
        .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

func getValue(data: Double)->String {
    
    let format = NumberFormatter()
    format.numberStyle = .decimal
    
    return format.string(for: data)!
}

func getDate(time: Double)->String {
    
    let date = Double(time / 1000)
    
    let format = DateFormatter()
    format.dateFormat = " hh:mm \n MMMM dd, YYYY"
    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
}

struct Case : Decodable {
    var cases : Double
    var deaths: Double
    var updated: Double
    var recovered: Double
    var active: Double
}

struct Details : Decodable,Hashable {
    var country: String
    var cases: Double
    var deaths: Double
    //var recovered: Double
    var critical: Double
}

class getData: ObservableObject {
    
    @Published var data : Case!
    @Published var countries = [Details]()
    
    init() {
        
        updateData()
    }
    
    func updateData() {
        
        let url = "https://corona.lmao.ninja/v2/all"
        let url1 = "https://corona.lmao.ninja/v2/countries/"
        
        let session = URLSession(configuration: .default)
        let session1 = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(Case.self, from: data!)
            
            DispatchQueue.main.async {
                self.data = json
            }
            
        }.resume()
        
        for i in country {
            
            session1.dataTask(with: URL(string: url1+i)!) { (data, _, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                let json = try! JSONDecoder().decode(Details.self, from: data!)
                
                DispatchQueue.main.async {
                    self.countries.append(json)
                    
                }
                
            }.resume()
        }   
    }
}

var country = ["usa", "uk", "france", "italy" , "spain", "belgium", "germany", "netherlands"
                ,"iran", "turkey", "canada", "brazil", "india", "mexico"]

struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
    
}
