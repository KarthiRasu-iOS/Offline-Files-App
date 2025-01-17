//
//  Extensions.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import Foundation


extension String {
    
    static var getAppName: String  {
        guard let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? Self else {
            return ""
        }
        return bundleName
    }
}
