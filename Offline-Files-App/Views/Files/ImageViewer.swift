//
//  ImageViewer.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//

import SwiftUI

struct ImageViewer: View {
    @State var data: Data?
    @State private var image: Image?
    @State var previewImage : Bool = false
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 70, height: 70)
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .fullScreenCover(isPresented: $previewImage, content: {
            ImagePreviewer(data: data ?? Data())
        })
        .onTapGesture {
            previewImage.toggle()
        }
    }
    
    private func loadImage() {
        
        DispatchQueue.global().async {
            if let data = data,
               let uiImage = downsample(imageAt: data, to: .init(width: 70, height: 70)) {
                let swiftUIImage = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.image = swiftUIImage
                }
            }
        }
    }
    
    func downsample(imageAt imageData: Data,
                    to pointSize: CGSize,
                    scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else {
            return nil
        }
        
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return UIImage(cgImage: downsampledImage)
    }
}
