//
//  HomeEllipsisOptionsView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import SwiftUI

struct HomeEllipsisOptionsView : View {
    var createNewFolder : (()->())?
    var body: some View {
        HStack {
            Button {
                
            } label: {
                HStack{
                    ZStack {
                        Rectangle()
                            .frame(width: 40,height: 40)
                            .foregroundStyle(.appBgSecondary)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.appTextSecondary)
                    }
                }
            }
            
            Menu {
                Button {
                    createNewFolder?()
                } label: {
                    HStack {
                        Text("New Folder")
                        Image(systemName: "folder.badge.plus")
                    }
                }

                Divider()
                
                Button {
                    
                } label: {
                    HStack {
                        Text("List")
                        Image(systemName: "list.bullet")
                    }
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Icons")
                        Image(systemName: "square.grid.2x2")
                    }
                }
                
                Divider()
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Sort")
                        Image("name_sort")
                    }
                }
                
            } label: {
                Image("ellipse_vertical")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                    .tint(.appTextSecondary)
                    .padding(.horizontal,5)
            }
        }
        
    }
}
