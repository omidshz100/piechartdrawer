//
//  ContentView.swift
//  ChartPie
//
//  Created by Omid Shojaeian Zanjani on 12/06/23.
//
//
import SwiftUI

struct ContentView: View {
    @State var data:[(Double,Color)] = [
                (2, .red)
            ]
    let colors:[Color] = [.red,.mint,.brown,.cyan,.green,.gray,.orange,.pink]
    var body: some View {
        VStack{
            PieChartView(slices: $data)
            HStack{
                Button("remove") {
                    if !(data.count < 2) {
                        data.removeLast()
                    }
                }
                Spacer()
                Button("Next") {
                    data.append((Double(2), colors.randomElement()!))
                    print(data.count)
                }
            }
        }
    }
    
    
}

struct PieChartView: View {
    @Binding var slices: [(Double, Color)]
    
    var body: some View {
         Canvas { context, size in
            let total = Double(16)//slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
             let gapSize = Angle(degrees: 5) // size of the gap between slices in degrees
            
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
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
