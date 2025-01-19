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
    case sortbyname
    case sortbycreationdate
}

enum FolderSortingOrder {
    case ascending
    case descending
    case creationDateAsc
    case creationDateDes
}


struct HomeEllipsisOptionsView : View {
    
    var performAction:((MenuActions)->())
    
    @State var viewSelectedOption : Int = 2
    @State var sortSelectedOption : Int = 1
    
    var body: some View {
        HStack {
            
            Menu {
                Button {
                    performAction(.newFolder)
                } label: {
                    HStack {
                        Text("New Folder")
                        Image(systemName: "folder.badge.plus")
                    }
                }
                
                Picker("", selection: $viewSelectedOption) {
                    
                    HStack {
                        Text("List")
                        Image(systemName: "list.bullet")
                    }
                    .tag(1)
                    
                    HStack {
                        Text("Icons")
                        Image(systemName: "square.grid.2x2")
                    }
                    .tag(2)
                }
                
                Picker("", selection: customBinding(for: $sortSelectedOption, menuAction: { newValue in
                    switch newValue {
                    case 1: performAction(.sortbyname)
                    case 2: performAction(.sortbycreationdate)
                    default: break
                    }
                })) {
                    HStack {
                        Text("Name")
                        Image("name_sort")
                    }
                    .tag(1)
                    
                    HStack {
                        Text("Created Date")
                        Image(systemName: "calendar")
                    }
                    .tag(2)
                }
                
            } label: {
                Image("ellipse_vertical")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                    .tint(.appTextSecondary)
                    .padding(.horizontal,5)
            }
            .onChange(of: viewSelectedOption, { _, newValue in
                switch newValue {
                case 1:
                    performAction(.list)
                case 2:
                    performAction(.grid)
                default:
                    break
                }
            })
        }
    }
    
    private func customBinding(for state: Binding<Int>, menuAction: @escaping (Int) -> Void) -> Binding<Int> {
        Binding(
            get: { state.wrappedValue },
            set: { newValue in
                state.wrappedValue = newValue
                menuAction(newValue)
            }
        )
    }
}
