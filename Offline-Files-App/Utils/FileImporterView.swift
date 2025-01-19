//
//  FileImporterView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//


import SwiftUI
import UniformTypeIdentifiers

struct FileImporterView: UIViewControllerRepresentable {
    @Binding var fileURL: URL?
    @Binding var fileData : Data?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [
            UTType.pdf,        // PDF files
            UTType.plainText,  // Plain text files
            UTType.rtf,        // Rich Text Format files
            UTType.text,       // General text files
            UTType.spreadsheet, // Excel documents (xls, xlsx)
            UTType(filenameExtension: "doc")!,    // Word .doc files
            UTType(filenameExtension: "docx")!,   // Word .docx files
            UTType(filenameExtension: "xls")!,    // Excel .xls files
            UTType(filenameExtension: "xlsx")!
        ])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: FileImporterView
        
        init(_ parent: FileImporterView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let fileURL = urls.first else { return }
            do {
                let fileData = try Data(contentsOf: fileURL)
                DispatchQueue.main.async {
                    self.parent.fileURL = fileURL
                    self.parent.fileData = fileData
                    self.parent.presentationMode.wrappedValue.dismiss()
                }
            } catch {
                print("Error reading file: \(error.localizedDescription)")
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
