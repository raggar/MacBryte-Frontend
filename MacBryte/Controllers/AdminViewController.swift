//
//  AdminViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-27.
//

import Foundation
import Cocoa

class AdminViewController: NSViewController {
    
    @objc dynamic var users: [User] = []
    
    @IBOutlet weak var savedButton: NSButton!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.titlebarAppearsTransparent = true
        self.view.window!.titleVisibility = .hidden
        self.view.window!.styleMask.remove(.resizable)
        self.view.window!.center()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedButton.title = "Save"
        getData(url: Constants.getUsersUrl, parameters: [:]) { result in
           if (!(result["error"] as! Bool)) {
               self.users = result["users"] as! [User]
           }
       }
    }
    
    @IBAction func savePressed(_ sender: NSButton) {
        savedButton.isEnabled = false
        savedButton.title = "Saving..."
        
        let usersData = users.map { (user) -> Dictionary<String, Any> in
            return user.asDictionary
        }
        
        postData(url: Constants.updateUsersUrl, parameters: ["updatedUsers": usersData]) { result in
            if (!(result["error"] as! Bool)) {
                self.savedButton.title = "Saved"
            } else {
                self.savedButton.title = "Error"
            }
            self.savedButton.isEnabled = true
        }
    }
}