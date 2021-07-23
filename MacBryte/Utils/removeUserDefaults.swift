//
//  removeUserDefaults.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-20.
//

import Foundation

func removeUserDefaults() {
    if let bundleID = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
}
