//
//  FolderBottomShape.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct FolderBottomShape : Shape {
    @State var cornerRadius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let corners : CGFloat = cornerRadius
        
        var path = Path()
        
        //Start from Left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY+corners))
        
        //Left top curve
        path.addQuadCurve(to: CGPoint(x: rect.minX+corners,
                                      y: rect.minY), control: CGPoint.zero)
        //Right top end
        path.addLine(to: CGPoint(x: rect.maxX-corners,
                                 y: rect.minY))
        //Right top curve
        path.addQuadCurve(to: CGPoint(x: rect.maxX,
                                      y: rect.minY + corners),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.minY))
        //Top right to bottom right
        path.addLine(to: CGPoint(x: rect.maxX,
                                 y: rect.maxY-corners))
        
        
        //Right bottom curve
        path.addQuadCurve(to: CGPoint(x: rect.maxX-corners,
                                      y: rect.maxY),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.maxY))
        //Right bottom to left bottom
        path.addLine(to: CGPoint(x: rect.minX+corners,
                                 y: rect.maxY))
        
        //Left bottom curve
        path.addQuadCurve(to: CGPoint(x: rect.minX,
                                      y: rect.maxY-corners),
                          control: CGPoint(x: rect.minX,
                                           y: rect.maxY))
        
        path.closeSubpath()
        
        return path
    }
}
