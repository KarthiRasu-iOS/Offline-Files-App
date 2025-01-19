//
//  FilesListView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//

import SwiftUI

struct FilesListView : View {
    @EnvironmentObject var orientationInfo : OrientationInfo
    @Binding var files : [FilesEntity]
    var numberOfItems : Int {
        orientationInfo.orientation == .portrait ?
        UIDevice.current.userInterfaceIdiom == .pad  ? 5 : 3
        :
        UIDevice.current.userInterfaceIdiom == .pad ? 6 : 5
    }
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 100)), count: numberOfItems)
    }
    
    var body: some View {
        LazyVGrid(columns: items,spacing: 20) {
            ForEach(files) { file in
                VStack {
                    if let fileType = file.fileType {
                        switch fileType.lowercased() {
                        case "jpg", "jpeg", "png" :
                            ImageViewer(data: file.data)
                        case "pdf","txt","docx","doc","xls","xlsx" :
                            DocViewer(data:file.data)
                        default :
                            EmptyView()
                        }
                    }
                    
                    Text(file.name ?? "")
                        .font(.poppins(.medium, size: 15))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom,20)
            }
        }
    }
}
