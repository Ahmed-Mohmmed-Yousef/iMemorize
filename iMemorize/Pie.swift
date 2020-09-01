//
//  Pie.swift
//  iMemorize
//
//  Created by Ahmed on 8/29/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngel: Angle
    var clockwise: Bool = true
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle.radians, endAngel.radians) }
        
        set {
            startAngle = Angle.radians(newValue.first)
            endAngel   = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let raduis = min(rect.width, rect.height) / 2
        let start  = CGPoint(
            x: center.x + raduis * cos(CGFloat(startAngle.radians)),
            y: center.y + raduis * cos(CGFloat(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: raduis,
                 startAngle: startAngle,
                 endAngle: endAngel,
                 clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}
