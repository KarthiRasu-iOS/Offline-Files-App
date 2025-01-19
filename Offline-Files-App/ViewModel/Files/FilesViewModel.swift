//
//  FilesViewModel.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//
import SwiftUI

class FilesViewModel : ObservableObject {
    
    @Published var folder : FoldersEntity
    
    @Published var fileURL : URL?
    @Published var data : Data?{
        didSet{
            saveFile()
        }
    }
    
    @Published var showFilePicker : Bool = false
    @Published var showImagesPicker : Bool = false
    
    let persistence = PersistenceController.shared
    
    init(folder: FoldersEntity) {
        self.folder = folder
    }
}

//MARK: - Store Image | file

extension FilesViewModel {
    func saveFile(){
        guard let url = fileURL,let fileData = data else { return }
        let filesEntity = FilesEntity(context: persistence.container.viewContext)
        filesEntity.referenceId = UUID().uuidString
        filesEntity.createdTimestamp = Date().timeIntervalSince1970.description
        filesEntity.data = fileData
        filesEntity.name = url.lastPathComponent
        filesEntity.fileType = url.pathExtension
        folder.addToFiles(filesEntity)
        persistence.saveChanges()
        data = nil
        fileURL = nil
    }
}
