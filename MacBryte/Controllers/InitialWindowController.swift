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
        super.windowDidLoad()
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        var size: NSSize
        
        if (UserDefaults.standard.string(forKey: Constants.userIdStorageKey) != nil && UserDefaults.standard.bool(forKey: Constants.userIsAdminStorageKey)) {
            let contentController: NSViewController
                = storyboard.instantiateController(withIdentifier: "adminViewController") as! NSViewController
            size = Constants.adminViewControllerSize
            self.window?.contentViewController = contentController
        } else if (UserDefaults.standard.string(forKey: Constants.userIdStorageKey) != nil) {
            let contentController: NSViewController = storyboard.instantiateController(withIdentifier: "accountViewController") as! NSViewController
            size = Constants.accountViewControllerSize
            self.window?.contentViewController = contentController
        } else {
            let contentController: NSTabViewController = storyboard.instantiateController(withIdentifier: "authenticationTabViewController") as! NSTabViewController
            size = Constants.authenticationTabControllerSize
            self.window?.contentViewController = contentController
        }
        
        self.window?.title = Constants.appWindowTitle
        self.window?.setContentSize(size)
        self.window?.styleMask.remove(.resizable)
        self.window?.center()
    }
}
