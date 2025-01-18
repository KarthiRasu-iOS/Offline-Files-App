//
//  FolderType.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 18/01/25.
//

import Foundation

enum FolderType {
        case list
        case grid
        
        var width : CGFloat {
            switch self {
            case .list:
                return 50
            case .grid:
                return 80
            }
        }
        
        var topHeight : CGFloat {
            switch self {
            case .list:
                return 8
            case .grid:
                return 13
            }
        }
        
        var bottomHeight : CGFloat {
            switch self {
            case .list:
                return 30
            case .grid:
                return 50
            }
        }
        
        var cornerRadius :  CGFloat {
            switch self {
            case .list:
                return 3
            case .grid:
                return 5
            }
        }
    }
