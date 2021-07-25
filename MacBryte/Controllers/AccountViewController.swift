//
//  AccountViewController.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-07-23.
//

import Cocoa
import Network
import Combine

class AccountViewController : NSViewController, NSTextFieldDelegate {
 
    @IBOutlet weak var controllerTitle: NSTextField!
    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var packagePurchasedField: NSTextField!
    @IBOutlet weak var hoursRemainingField: NSTextField!
    @IBOutlet weak var grandTotalHoursField: NSTextField!
    @IBOutlet weak var zoomLinkField: NSButton!
    @IBOutlet weak var signOutButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userId = UserDefaults.standard.string(forKey: Constants.userIdStorageKey) else {
            fatalError("Cannot find user id")
        }
        
        getData(url: Constants.getUserUrl, parameters: ["userId": userId]) { result in
            if (!(result["error"] as! Bool)) {
                self.controllerTitle.stringValue = "\(result["firstname"]!) \(result["lastname"]!)'s Account"
                self.emailField.stringValue = result["email"] as! String
                self.hoursRemainingField.stringValue = String(result["hoursRemaining"] as! Int)
                self.grandTotalHoursField.stringValue = String(result["grandTotalHours"] as! Int)
                self.packagePurchasedField.stringValue = String(result["packagePurchased"] as! String)
                
                let zoomLink = ("" == (result["zoomLink"] as! String)) ? Constants.noZoomLink : (result["zoomLink"] as! String)
                if zoomLink == "" {
                     self.zoomLinkField.title = "None"
                     self.zoomLinkField.isEnabled = false
                 } else {
                     if zoomLink == Constants.noZoomLink {
                        self.zoomLinkField.title = Constants.noZoomLink
                        self.zoomLinkField.isEnabled = false
                     } else {
                        self.zoomLinkField.title = zoomLink
                        self.zoomLinkField.isEnabled = true
                     }
                 }
            }
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.title = Constants.appWindowTitle
        self.view.window!.setContentSize(Constants.accountViewControllerSize)
        self.view.window!.styleMask.remove(.resizable)
        self.view.window!.center()
    }
    
    @IBAction func zoomLinkClicked(_ sender: Any) {
        if (zoomLinkField.stringValue != "None") {
            LinkerService.link(to: zoomLinkField.title)
        }
    }
    
    @IBAction func signOutUser(_ sender: Any) {
        self.view.window!.performClose(nil)
        removeUserDefaults()
        performSegue(withIdentifier: "accountToAuthentication", sender: self)
    }
}

