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
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var packagePurchasedField: NSTextField!
    @IBOutlet weak var hoursRemainingField: NSTextField!
    @IBOutlet weak var grandTotalHoursField: NSTextField!
    @IBOutlet weak var zoomLinkField: NSButton!
    @IBOutlet weak var signOutButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstNameValue = UserDefaults.standard.string(forKey: Constants.userFirstNameStorageKey), let lastNameValue = UserDefaults.standard.string(forKey: Constants.userLastNameStorageKey){
            nameField.stringValue = firstNameValue + " " + lastNameValue
        }
        
        if let emailValue = UserDefaults.standard.string(forKey: Constants.userEmailStorageKey) {
            emailField.stringValue = emailValue
        }
        
        if let zoomLinkValue = UserDefaults.standard.string(forKey: Constants.userZoomLinkStorageKey) {
            zoomLinkField.title = zoomLinkValue
        }
        
        if let packagePurchasedValue = UserDefaults.standard.string(forKey: Constants.userPackagePurchasedStorageKey) {
            packagePurchasedField.stringValue = packagePurchasedValue
        }
        
        if let hoursRemianingValue = UserDefaults.standard.string(forKey: Constants.userHoursRemainingStorageKey) {
            hoursRemainingField.stringValue = hoursRemianingValue
        }
        
        if let grandTotalHoursValue = UserDefaults.standard.string(forKey: Constants.userGrandTotalHoursStorageKey) {
            grandTotalHoursField.stringValue = grandTotalHoursValue
        }

    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    /*
     Opens Zoom link in browser
     */
    @IBAction func zoomLinkClicked(_ sender: Any) {
        LinkerService.link(to: zoomLinkField.title)
    }
    
    @IBAction func signOutUser(_ sender: Any) {
    }
}

