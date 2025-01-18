//
//  HomeEllipsisOptionsView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import SwiftUI

enum MenuActions {
    case newFolder
    case list
    case grid
    case sort
}

struct HomeEllipsisOptionsView : View {
    
    var performAction:((MenuActions)->())
    
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
                    performAction(.newFolder)
                } label: {
                    HStack {
                        Text("New Folder")
                        Image(systemName: "folder.badge.plus")
                    }
                }

                Divider()
                
                Button {
                    performAction(.list)
                } label: {
                    HStack {
                        Text("List")
                        Image(systemName: "list.bullet")
                    }
                }
                
                Button {
                    performAction(.grid)
                } label: {
                    HStack {
                        Text("Icons")
                        Image(systemName: "square.grid.2x2")
                    }
                }
                
                Divider()
                
                Button {
                    performAction(.sort)
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
