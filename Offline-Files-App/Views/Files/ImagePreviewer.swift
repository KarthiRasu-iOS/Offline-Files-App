//
//  ImagePreviewer.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//

import SwiftUI

struct ImagePreviewer : View {
    @State var data : Data
    @State var image : Image?
    var body: some View {
        ZStack {
            Color.appBgPrimary.opacity(0.8)
                .ignoresSafeArea()
            VStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                }
            }
            .onAppear {
                getImageFromData(data: data)
            }
        }
        .background(BackgroundClearView())
    }
    
    func getImageFromData(data:Data){
        DispatchQueue.global().async {
            if let data = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: data)
                }
            }
        }
    }
}
