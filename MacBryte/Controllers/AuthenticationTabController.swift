//
//  AuthenticationTabController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-20.
//

import Cocoa

class AuthenticationTabController: NSTabViewController {
    
    func transitionControllers(window: NSWindowController?, segueIdentifier: String) {
        guard window != nil else {
            fatalError("Window controller does not exist")
        }
        window!.close()
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }

    override func viewDidAppear() {
        super.viewDidAppear()
//        let userId = UserDefaults.standard.string(forKey: "userId")?.boolValueFromString
//        if userId {
//            transitionControllers(window: self.view.window?.windowController, segueIdentifier: "goToCustomerDashboard")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
