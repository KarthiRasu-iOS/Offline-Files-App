//
//  WelcomeNoteView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import SwiftUI

struct WelcomeNoteView : View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Hello,")
                .font(.poppins(.regular, size: 25))
            Text("Karthi Rasu")
                .font(.poppins(.semibold, size: 25))
        }
        .padding(.leading)
    }
}
