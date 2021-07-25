//
//  AccountViewController.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-07-23.
//

import Cocoa
import Network
import Combine
import SwiftUI

class AccountViewController : NSViewController, NSTextFieldDelegate {
    
    @ObservedObject var userEntity: UserEntity = UserEntity.shared
 
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
        
        self.controllerTitle.stringValue = "\(userEntity.userData.firstName) \(userEntity.userData.lastName)'s Account"
        
        self.emailField.stringValue = userEntity.userData.email
        self.hoursRemainingField.stringValue = userEntity.userData.hoursRemaining
        self.grandTotalHoursField.stringValue = userEntity.userData.grandTotalHours
        self.packagePurchasedField.stringValue = userEntity.userData.packagePurchased
        
        let zoomLink = userEntity.userData.zoomLink
        if zoomLink == "" {
            self.zoomLinkField.title = "None"
            self.zoomLinkField.isEnabled = false
        } else {
            if zoomLink == Constants.noZoomLink {
                zoomLinkField.title = Constants.noZoomLink
                zoomLinkField.isEnabled = false
            } else {
                zoomLinkField.title = zoomLink
                zoomLinkField.isEnabled = true
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
        
        userEntity.setUser(user: UserData(firstName: "", lastName: "", email: "", zoomLink: "", packagePurchased: "", hoursRemaining: "", grandTotalHours: ""))
        
        performSegue(withIdentifier: "accountToAuthentication", sender: self)
    }
}

