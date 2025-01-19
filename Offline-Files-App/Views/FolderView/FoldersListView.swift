//
//  FoldersListView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct FoldersListView : View {
    @Binding var folders : [FoldersEntity]
    @Binding var navPath : NavigationPath
    var editFolderName : ((FoldersEntity)->())
    @State var folderColor : Color = .appTheme
    var body: some View {
        ForEach(folders) { folder in
            HStack{
                FolderShapeView(folderType: .list,
                                color: .constant(folder.tag ?? ""),
                                preViewColor: $folderColor)
                    .frame(height: 70)
                VStack(alignment: .leading){
                    Text(folder.name ?? "")
                        .font(.poppins(.medium, size: 15))
                    Text(String.formatDate(folder.createdTimestamp ?? ""))
                        .foregroundStyle(.gray)
                        .font(.poppins(.medium, size: 13))
                }
                Spacer()
                if folder.isFavourite {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                        .padding(.horizontal)
                }
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(Color(.appTextSecondary))
            }
            .onTapGesture {
                navPath.append(folder)
            }
            .onLongPressGesture {
                editFolderName(folder)
            }
        }
        .padding(.horizontal)
    }
}

