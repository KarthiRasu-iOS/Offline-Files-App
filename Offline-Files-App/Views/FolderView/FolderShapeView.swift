//
//  FolderShapeView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//


import SwiftUI

struct FolderShapeView : View {
    
    @State var folderType : FolderType
    @Binding var color : String
    @Binding var preViewColor : Color
    
    var body: some View {
        VStack(spacing:0){
            
            FolderTopShape(cornerRadius: folderType.cornerRadius)
                .fill(Color.init(hex: color) ?? preViewColor)
                .frame(width: folderType.width,
                       height: folderType.topHeight)
            
            FolderBottomShape(cornerRadius: folderType.cornerRadius)
                .fill(Color.init(hex: color) ?? preViewColor)
                .frame(width: folderType.width,
                       height: folderType.bottomHeight)
                .shadow(color:.black.opacity(0.3),radius: 2,y: 0)
        }
    }
}
