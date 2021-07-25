//
//  InitialWindowController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-21.
//

import Foundation
import Cocoa

class InitialWindowController: NSWindowController {
    
    var userEntity: UserEntity = UserEntity.shared
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        var size: NSSize
        
        if UserDefaults.standard.string(forKey: Constants.userIdStorageKey) != nil {
            let contentController: NSViewController
            
            if UserDefaults.standard.bool(forKey: Constants.userIsAdminStorageKey) {
                contentController = storyboard.instantiateController(withIdentifier: "adminViewController") as! NSViewController
                size = Constants.adminViewControllerSize
            } else {
                contentController = storyboard.instantiateController(withIdentifier: "accountViewController") as! NSViewController
                size = Constants.accountViewControllerSize
            }
            
            let getParams: Dictionary<String, String> = ["_id": UserDefaults.standard.string(forKey: Constants.userIdStorageKey)!]
                        
            getData(url: Constants.getUserUrl, parameters: getParams) { (result) in
                if !(result["error"] as! Bool) {
                    print(result)
                    self.userEntity.setUser(user: UserData(
                                        firstName: result["firstname"] as! String,
                                        lastName: result["lastname"] as! String,
                                        email: result["email"] as! String,
                                        zoomLink: ("" == (result["zoomLink"] as! String)) ? Constants.noZoomLink : (result["zoomLink"] as! String),
                                        packagePurchased: result["packagePurchased"] as! String,
                                        hoursRemaining: String(result["hoursRemaining"] as! Int),
                                        grandTotalHours: String(result["grandTotalHours"] as! Int))
                    )
                }
                
                self.window?.contentViewController = contentController
            }
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
    
    func getUserInformation() -> Void {
        
    }
}
