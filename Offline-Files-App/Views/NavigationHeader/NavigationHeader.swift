//
//  NavigationHeader.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//


import SwiftUI

struct NavigationHeader : View {
    
    var headerTitle : String

    var backAction : (()->())? = nil
            
    var body: some View {
        ZStack {
            if (backAction != nil) {
                Button {
                    backAction?()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(.appTextSecondary))
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }

            Text(headerTitle)
                .foregroundStyle(Color(.appTextPrimary))
                .font(.poppins(.medium, size: 20))
        }
        .padding(.horizontal)
        .padding(.top,8)
    }
}
