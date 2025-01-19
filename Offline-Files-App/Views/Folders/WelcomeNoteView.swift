//
//  WelcomeNoteView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import SwiftUI

struct WelcomeNoteView : View {
    
    @EnvironmentObject var orientationInfo : OrientationInfo
    @AppStorage(AppStorageKeys.userName.rawValue) var userName = ""
    var body: some View {
        let layout = orientationInfo.orientation == .portrait ? AnyLayout(VStackLayout(alignment: .leading)) : AnyLayout(HStackLayout())
        layout {
            Text("Hello,")
                .font(.poppins(.regular, size: 25))
            Text(userName)
                .font(.poppins(.semibold, size: 25))
        }
        .padding(.leading)
    }
}
