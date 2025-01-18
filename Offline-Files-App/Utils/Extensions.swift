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
}


extension CGFloat {
    static var width = UIScreen.main.bounds.width
    static var height = UIScreen.main.bounds.height
}

extension View {
    func keyboardHeight(_ state: Binding<CGFloat>) -> some View {
        self.modifier(KeyboardProvider(keyboardHeight: state))
    }
}
