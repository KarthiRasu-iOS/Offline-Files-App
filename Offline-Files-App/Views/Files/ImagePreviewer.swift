//
//  ImagePreviewer.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//

import SwiftUI

struct ImagePreviewer : View {
    @Environment(\.dismiss) var dismiss
    @State var data : Data
    var body: some View {
        ZStack {
            Color.appBgPrimary.opacity(0.8)
                .ignoresSafeArea()
            VStack {
                if let image = getImageFromData(data: data) {
                    image
                        .resizable()
                        .scaledToFit()
                }
            }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.appTheme)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
            .padding()
        }
        .background(BackgroundClearView())
    }
    
    func getImageFromData(data:Data)->Image?{
        if let data = UIImage(data: data) {
            return Image(uiImage: data)
        }
        return nil
    }
}
