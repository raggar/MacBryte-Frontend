//
//  LinkerService.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-11.
//

import Foundation
import Cocoa

/*
 Handles all link redirections in the application
 */
class LinkerService : NSObject {
    static func link(to link: String) {
        if let url = URL(string: link) {
            NSWorkspace.shared.open(url)
        }
    }
}
