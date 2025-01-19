//
//  Extensions.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import Foundation
import UIKit
import SwiftUI

extension String {
    
    static var getAppName: String  {
        guard let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? Self else {
            return ""
        }
        return bundleName
    }
    
    static func formatDate(_ timestamp : String) -> String{
        if let timestamp = TimeInterval(timestamp) {
            let date = Date(timeIntervalSince1970: timestamp)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm a"
            dateFormatter.timeZone = TimeZone.current

            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            print("Invalid timestamp string")
            return ""
        }
    }
}


extension CGFloat {
    static var width = UIScreen.main.bounds.width
    static var height = UIScreen.main.bounds.height
}

extension View {
    func keyboardHeight(_ state: Binding<CGFloat>) -> some View {
        self.modifier(KeyboardProvider(keyboardHeight: state))
    }
    
    func presentNewFolderView(isPresented: Binding<Bool>,folderName : Binding<String>,
                              isFav : Binding<Bool>,
                              folderColor:Binding<Color>,
                              confirmFolderAction:@escaping (()->())) -> some View {
        fullScreenCover(isPresented: isPresented, content: {
            NewFolderNameView(folderName: folderName,
                              isFav: isFav,
                              folderColor: folderColor,
                              confirmFolderAction: confirmFolderAction)
            .background(BackgroundClearView())
        })
        .transaction { transaction in
            if isPresented.wrappedValue {
                transaction.disablesAnimations = true
                transaction.animation = .smooth
            }
        }
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        guard let hexNumber = Int(hexSanitized, radix: 16) else {
            return nil
        }
        
        let red, green, blue, alpha: Double
        
        switch hexSanitized.count {
        case 6: // RGB
            red = Double((hexNumber >> 16) & 0xFF) / 255.0
            green = Double((hexNumber >> 8) & 0xFF) / 255.0
            blue = Double(hexNumber & 0xFF) / 255.0
            alpha = 1.0
        case 8: // RGBA
            red = Double((hexNumber >> 24) & 0xFF) / 255.0
            green = Double((hexNumber >> 16) & 0xFF) / 255.0
            blue = Double((hexNumber >> 8) & 0xFF) / 255.0
            alpha = Double(hexNumber & 0xFF) / 255.0
        default:
            return nil
        }
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension Color {
    
    func toHexString() -> String? {
        let uiColor = UIColor(self)
        guard let components = uiColor.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        let alpha = components.count >= 4 ? components[3] : 1.0
        
        if alpha < 1.0 {
            return String(format: "#%02lX%02lX%02lX%02lX",
                          lroundf(Float(red * 255)),
                          lroundf(Float(green * 255)),
                          lroundf(Float(blue * 255)),
                          lroundf(Float(alpha * 255)))
        } else {
            return String(format: "#%02lX%02lX%02lX",
                          lroundf(Float(red * 255)),
                          lroundf(Float(green * 255)),
                          lroundf(Float(blue * 255)))
        }
    }
}
