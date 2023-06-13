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

struct PieChartView: View {
    @Binding var slices: [(Double, Color)]
    @Binding var total:Double
    @Binding var gap:Double
    var body: some View {
         Canvas { context, size in
             // for size of each pie declair ....
            let total = Double(total)//slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            let gapSize = Angle(degrees: gap) // size of the gap between slices in degrees
            
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle - gapSize
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle + gapSize
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
