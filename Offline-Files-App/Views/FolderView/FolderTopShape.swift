//
//  FolderTopShape.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct FolderTopShape : Shape {
    
    @State var cornerRadius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let corners : CGFloat = cornerRadius
        
        let thirtyPercent = rect.width * 0.3
        
        let centerCurveRadius : CGFloat = cornerRadius/2
        
        var path = Path()
        
        //Start from left
        path.move(to: CGPoint(x: rect.minX,
                              y: rect.minY+corners))
        
        //Left Curve
        
        path.addQuadCurve(to: CGPoint(x: rect.minX+corners,
                                      y: rect.minY),
                          control: CGPoint.zero)
        
        //Left to Center line
        
        path.addLine(to: CGPoint(x: rect.minX+thirtyPercent-centerCurveRadius,
                                 y: rect.minY))
        
        //Top Center curve
        path.addQuadCurve(to: CGPoint(x: rect.minX+thirtyPercent+centerCurveRadius,
                                      y: rect.minY+centerCurveRadius),
                          control: CGPoint(x: rect.minX+thirtyPercent,
                                           y: rect.minY))
        
        //Center to mid slope line
        
        path.addLine(to: CGPoint(x: rect.midX-corners*1.5,
                                 y: rect.midY))
        
        //Mid slope to right mid end
        path.addLine(to: CGPoint(x: rect.maxX - corners/2,
                                 y: rect.midY))
        
        //Right mid end curve
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX,
                                      y: rect.midY+corners/2),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.midY))
        
        //Right mid to right bottom end
        path.addLine(to: CGPoint(x: rect.maxX,
                                 y: rect.maxY+corners))
        
        //Right bottom to left bottom end
        path.addLine(to: CGPoint(x: rect.minX,
                                 y: rect.maxY+corners))
        
        path.closeSubpath()
        
        return path
    }
}
