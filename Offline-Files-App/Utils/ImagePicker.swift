//
//  ImagePicker.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//


import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var fileURL: URL?
    @Binding var fileData : Data?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let imageurl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                do {
                    let fileData = try Data(contentsOf: imageurl)
                    DispatchQueue.main.async {
                        self.parent.fileURL = imageurl
                        self.parent.fileData = fileData
                        self.parent.presentationMode.wrappedValue.dismiss()
                    }
                    
                }catch {
                    print("Error in reading image")
                    parent.presentationMode.wrappedValue.dismiss()
                }
            }else{
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
