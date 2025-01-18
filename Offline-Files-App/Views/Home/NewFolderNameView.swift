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
    
    var createNewFolder : (()->())
    
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
                        createNewFolder()
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
        .background(BackgroundClearView())
    }
}
