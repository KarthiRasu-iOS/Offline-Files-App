//
//  FilesView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//

import SwiftUI

struct FilesHomeView : View {
    
    @Environment(\.dismiss) var popBack
        
    @ObservedObject var filesViewModel : FilesViewModel
    
    init(folder: FoldersEntity) {
        self.filesViewModel = FilesViewModel(folder: folder)
    }
    
    var body: some View {
        ZStack {
            Color.appBgPrimary
                .ignoresSafeArea()
            VStack {
                NavigationHeader(headerTitle: filesViewModel.folder.name ?? "Files") {
                    popBack()
                }
                if filesViewModel.folder.files?.count == 0 {
                    VStack(spacing:15) {
                        Image(systemName: "folder.fill")
                            .font(.title)
                        Text("Folder is empty")
                            .font(.poppins(.medium, size: 20))
                    }
                    .foregroundStyle(Color.appTextSecondary)
                    .frame(maxHeight: .infinity,alignment: .center)
                }else{
                    if let files = filesViewModel.folder.files?.array as? [FilesEntity] {
                        FilesListView(files:.constant(files))
                    }
                    Spacer()
                }
                
                HStack {
                    Button {
                        if let files = filesViewModel.folder.files?.array as? [FilesEntity] {
                            print(files)
                        }
                        filesViewModel.showImagesPicker.toggle()
                    } label: {
                        Text("Browse Photos")
                            .font(.poppins(.medium, size: 17))
                            .foregroundStyle(Color.appTextPrimary)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appTheme,lineWidth: 1)
                    })
                    
                    Button {
                        
                        filesViewModel.showFilePicker.toggle()
                    } label: {
                        Text("Browse files")
                            .font(.poppins(.medium, size: 17))
                            .foregroundStyle(Color.appWhiteText)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.appTheme)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
            .sheet(isPresented: $filesViewModel.showFilePicker,content: {
                FileImporterView(fileURL: $filesViewModel.fileURL,
                                 fileData: $filesViewModel.data)
                .ignoresSafeArea()
                .presentationDetents([.height(.height*0.6)])
            })
            
            .sheet(isPresented: $filesViewModel.showImagesPicker,content: {
                ImagePicker(sourceType: .photoLibrary,fileURL: $filesViewModel.fileURL,fileData: $filesViewModel.data)
                    .ignoresSafeArea()
                    .presentationDetents([.height(.height*0.6)])
            })
            .navigationBarBackButtonHidden()
        }
    }
}
