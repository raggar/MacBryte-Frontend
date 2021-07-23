//
//  InitialWindowController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-21.
//

import Foundation
import Cocoa

class InitialWindowController: NSWindowController {
    override func windowDidLoad() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
    
        var contentController: NSTabViewController
        var size: NSSize
        if (UserDefaults.standard.string(forKey: "userId") == nil && UserDefaults.standard.bool(forKey: "isAdmin")) {
            // edit for admin portal
            contentController = storyboard.instantiateController(withIdentifier: "authenticationTabViewController") as! NSTabViewController
            size = NSSize(width: 400, height: 400)
        } else if (UserDefaults.standard.string(forKey: "userId") != nil) {
            contentController = storyboard.instantiateController(withIdentifier: "dataTabViewController") as! NSTabViewController
            size = NSSize(width: 500, height: 500)
        }
        else {
            contentController = storyboard.instantiateController(withIdentifier: "authenticationTabViewController") as! NSTabViewController
            size = NSSize(width: 400, height: 450)
        }

        self.window?.contentViewController = contentController
        self.window?.setContentSize(size)
        self.window?.styleMask.remove(.resizable)
        self.window?.center()
    }
}
