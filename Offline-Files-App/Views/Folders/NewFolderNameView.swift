//
//  NewFolderNameView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct NewFolderNameView : View {
    @Environment(\.dismiss) var dismiss
    @Binding var folderName : String
    @Binding var isFav : Bool
    @Binding var folderColor : Color
    var confirmFolderAction : (()->())
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Create New Folder")
                    .font(.poppins(.semibold, size: 17))
                    .padding(.top)
                TextField("Enter Folder Name", text: $folderName)
                    .frame(height: 50)
                    .textFieldStyle(.plain)
                    .font(.poppins(.medium, size: 15))
                    .multilineTextAlignment(.center)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appTheme,lineWidth: 1)
                    }
                    .padding([.horizontal,.top])
                    .autocorrectionDisabled()
                
                Toggle(isOn: $isFav) {
                    Text("Favourite")
                        .font(.poppins(.medium, size: 17))
                }
                .padding([.horizontal,.top])
                
                HStack {
                    ColorPicker(selection: $folderColor,supportsOpacity: false) {
                        Text("Folder Color")
                            .font(.poppins(.medium, size: 17))
                    }
                    FolderShapeView(folderType: .list, color: .constant(""), preViewColor: $folderColor)
                        .padding(.leading)
                }
                .padding()
                
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .frame(height: 50)
                            .foregroundStyle(Color.appTextSecondary)
                            .font(.poppins(.medium, size: 15))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.appBgPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Button{
                        dismiss()
                        confirmFolderAction()
                    } label: {
                        Text("OK")
                            .frame(height: 50)
                            .foregroundStyle(folderName.isEmpty ? Color.gray : Color.appWhiteText)
                            .font(.poppins(.medium, size: 15))
                    }
                    .disabled(folderName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .background(folderName.isEmpty ? Color.appBgPrimary.opacity(0.5) : Color.appTheme)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                .padding()
            }
            .background(Color.appBgSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
        }
        .onAppear(perform: {
            UIView.setAnimationsEnabled(false)
        })
        .onDisappear(perform: {
            UIView.setAnimationsEnabled(true)
        })
    }
}
//
//#Preview {
//    @Previewable @State var name : String = ""
//    @Previewable @State var isFav : Bool = false
//    NewFolderNameView(folderName: $name, isFav: $isFav) {
//        
//    }
//}
