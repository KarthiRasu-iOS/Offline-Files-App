//
//  DocViewer.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 19/01/25.
//

import SwiftUI

struct DocViewer : View {
    @State var data : Data?
    var body: some View {
        Image(.document)
            .resizable()
            .scaledToFit()
            .frame(width: 70,height: 70)
            .tint(.appTheme)
    }
}
