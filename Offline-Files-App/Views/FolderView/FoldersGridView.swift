//
//  FoldersGridView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct FoldersGridView : View {
    @EnvironmentObject var orientationInfo : OrientationInfo
    @Binding var folders : [FoldersEntity]
    @Binding var navPath : NavigationPath
    @State var folderColor : Color = .appTheme
    var editFolderName : ((FoldersEntity)->())
        
    var numberOfItems : Int {
        orientationInfo.orientation == .portrait ?
        UIDevice.current.userInterfaceIdiom == .pad  ? 5 : 3
        :
        UIDevice.current.userInterfaceIdiom == .pad ? 6 : 5
    }
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: UIDevice.current.userInterfaceIdiom == .pad ? 200 : 100)), count: numberOfItems)
    }
    
    var body: some View {
        LazyVGrid(columns: items,spacing: 20) {
            ForEach(folders) { folder in
                VStack {
                    FolderShapeView(folderType: .grid,
                                    color: .constant(folder.tag ?? ""),
                                    preViewColor: $folderColor)
                        .frame(height: 70)
                    Text(folder.name ?? "")
                        .font(.poppins(.medium, size: 15))
                }
                .overlay(content: {
                    if folder.isFavourite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(Color.red)
                    }
                })
                .padding(.bottom,20)
                .onTapGesture {
                    navPath.append(folder)
                }
                .onLongPressGesture {
                    editFolderName(folder)
                }
            }
        }
    }
}
