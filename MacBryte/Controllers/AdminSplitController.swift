//
//  AdminViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-24.
//

import Foundation
import Cocoa

class AdminSplitController : NSSplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.titlebarAppearsTransparent = true
        self.view.window!.titleVisibility = .hidden
        self.view.window!.setContentSize(Constants.adminViewControllerSize)
        self.view.window!.styleMask.remove(.resizable)
        self.view.window!.center()
    }
}
