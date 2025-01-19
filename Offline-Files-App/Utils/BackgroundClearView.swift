//
//  BackgroundClearView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//


import SwiftUI

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
