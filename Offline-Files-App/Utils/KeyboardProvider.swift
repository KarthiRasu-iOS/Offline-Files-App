//
//  KeyboardProvider.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import SwiftUI

struct KeyboardProvider: ViewModifier {
    
    var keyboardHeight: Binding<CGFloat>
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification),
                       perform: { notification in
                guard let userInfo = notification.userInfo,
                      let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                
                withAnimation {
                    self.keyboardHeight.wrappedValue = keyboardRect.height + 100 //100 for suggesstion bar
                    
                }
                
            }).onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification),
                         perform: { _ in
                withAnimation {
                    self.keyboardHeight.wrappedValue = 0
                }
            })
    }
}
