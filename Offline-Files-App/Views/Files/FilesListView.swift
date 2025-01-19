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
    
    @State private var showFilePreview = false
    @State private var fileURL: URL?
    
    var body: some View {
        LazyVGrid(columns: items,spacing: 20) {
            ForEach(files) { file in
                VStack {
                    if let fileType = file.fileType {
                        switch fileType.lowercased() {
                        case "jpg", "jpeg", "png" :
                            ImageViewer(data: file.data)
                        case "pdf","txt","docx","doc","xls","xlsx" :
                            if let tempFileURL = saveBinaryFileToTemp(file: file) {
                                FilePreview(fileURL: tempFileURL)
                                    .frame(width: 70, height: 100)
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .onTapGesture {
                                        fileURL = tempFileURL
                                        showFilePreview.toggle()
                                    }
                            }
                        default :
                            EmptyView()
                        }
                    }
                    Text(file.name ?? "")
                        .font(.poppins(.medium, size: 15))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .padding(.bottom,20)
                .sheet(isPresented: $showFilePreview) {
                    if let fileURL = fileURL {
                        FilePreview(fileURL: fileURL)
                    }
                }
            }
        }
    }
    
    func saveBinaryFileToTemp(file:FilesEntity) -> URL? {
        let binaryData = file.data
        
        let tempDir = FileManager.default.temporaryDirectory
        let fileName = file.name ?? ""
        let fileURL = tempDir.appendingPathComponent(fileName).appendingPathExtension(file.fileType ?? "")
        
        do {
            try binaryData?.write(to: fileURL)
            return fileURL
        } catch {
            print("Error writing file: \(error)")
            return nil
        }
    }
}
