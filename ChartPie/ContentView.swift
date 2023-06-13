//
//  ContentView.swift
//  ChartPie
//
//  Created by Omid Shojaeian Zanjani on 12/06/23.
//
//
import SwiftUI

struct ContentView: View {
    @State var slices:[(Double,Color)] = [(1, .red)]
    @State var total:Double = 10.0
    @State var gap:Double = 5.0
    
    
    let colors:[Color] = [.red,.mint,.brown,.cyan,.green,.gray,.orange,.pink,.orange]
    var body: some View {
        VStack{
            PieChartView(slices: $slices, total: $total, gap: $gap)
            HStack{
                Button("remove") {
                    if !(slices.count < 2) {
                        slices.removeLast()
                    }
                }
                Spacer()
                Button("Next") {
                    slices.append((Double(1), colors.randomElement()!))
                    print(slices.count)
                }
            }
            
            Slider(value: $gap, in: 0...10) {
                               Text("Label")
                           } minimumValueLabel: {
                               Image(systemName: "tortoise")
                           } maximumValueLabel: {
                               Image(systemName: "hare")
                           } onEditingChanged: {
                               print("\($0)")
                           }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
