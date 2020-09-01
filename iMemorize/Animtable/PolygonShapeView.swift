//
//  PolygonShapeView.swift
//  iMemorize
//
//  Created by Ahmed on 9/1/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import SwiftUI

struct PolygonShapeView: View {
    @State private var sides: Double = 4
    @State private var scale: Double = 1.0
    
    
    var body: some View {
        VStack {
            PolygonShape(sides: sides, scale: scale)
                .stroke(Color.pink, lineWidth: (sides < 3) ? 10 : ( sides < 7 ? 5 : 2))
                .padding(20)
                .animation(.easeInOut(duration: 0.5))
                .layoutPriority(1)
            
            
            Text("\(Int(sides)) sides, \(String(format: "%.2f", scale as Double)) scale")
            
            VStack {
                Slider(value: $sides, in: 0...10)
                Slider(value: $scale, in: 0.5...1)
            }
                .padding()
            
            
            
        }.navigationBarTitle("Example 4").padding(.bottom, 50)
    }
}

struct PolygonShapeView_Previews: PreviewProvider {
    static var previews: some View {
        PolygonShapeView()
    }
}




struct MyButton: View {
    let label: String
    var font: Font = .title
    var textColor: Color = .white
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(label)
                .font(font)
                .padding(10)
                .frame(width: 70)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                .foregroundColor(textColor)
            
        })
    }
}


struct PolygonShape: Shape {
    var sides: Double
    var scale: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(sides, scale) }
        set {
            sides = newValue.first
            scale = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        let extra: Int = sides != Double(Int(sides)) ? 1 : 0
        
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / sides)) * (Double.pi / 180)
            
            // Calculate vertex
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}
