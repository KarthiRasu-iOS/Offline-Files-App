//
//  FoldersListView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct FoldersListView : View {
    @Binding var folders : [FoldersEntity]
    var body: some View {
        ForEach(folders) { folder in
            HStack{
                FolderShapeView(folderType: .list)
                    .frame(height: 70)
                VStack(alignment: .leading){
                    Text(folder.name ?? "")
                        .font(.poppins(.medium, size: 15))
                    Text(format(folder.createdTimestamp ?? ""))
                        .foregroundStyle(.gray)
                        .font(.poppins(.medium, size: 13))
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    func format(_ timestamp : String) -> String{
        if let timestamp = TimeInterval(timestamp) {
            // Convert the timestamp to a Date object
            let date = Date(timeIntervalSince1970: timestamp)

            // Create a DateFormatter for the desired format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.timeZone = TimeZone.current // Optional: Set your preferred timezone

            // Convert the Date object to a formatted string
            let formattedDate = dateFormatter.string(from: date)
            print("Formatted Date: \(formattedDate)") // Output: 21/11/2023 (example)
            return formattedDate
        } else {
            print("Invalid timestamp string")
            return ""
        }
    }
}

