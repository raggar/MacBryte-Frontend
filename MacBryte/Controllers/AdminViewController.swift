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
    @IBOutlet weak var signOutButton: NSButton!
    @IBOutlet weak var confirmationMessage: NSTextField!
    
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
        confirmationMessage.stringValue = Constants.defaultStatusText
        
        getData(url: Constants.getUsersUrl, parameters: [:]) { result in
           if (!(result["error"] as! Bool)) {
               self.users = result["users"] as! [User]
           }
       }
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        self.view.window!.performClose(nil)
        removeUserDefaults()
        performSegue(withIdentifier: "adminToAuthentication", sender: self)
    }
    
    @IBAction func savePressed(_ sender: NSButton) {
        savedButton.isEnabled = false
        savedButton.title = "Saving..."
        
        let usersData = users.map { (user) -> Dictionary<String, Any> in
            return user.asDictionary
        }
        
        postData(url: Constants.updateUsersUrl, parameters: ["updatedUsers": usersData]) { result in
            if (!(result["error"] as! Bool)) {
                self.confirmationMessage.stringValue = Constants.savingDataOk
            } else {
                self.confirmationMessage.stringValue = Constants.savingDataFailed
            }
            self.savedButton.isEnabled = true
            self.savedButton.title = "Save"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.confirmationMessage.stringValue = Constants.defaultStatusText
            }
        }
    }
}
