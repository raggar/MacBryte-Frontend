//
//  SignupViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-20.
//

import Foundation
import Cocoa
import Network
import Alamofire
import SwiftyJSON

class SignupViewController: NSViewController, NSTextFieldDelegate {
    
    
    @IBOutlet weak var firstnameInput: NSTextField!
    @IBOutlet weak var lastnameInput: NSTextField!
    @IBOutlet weak var emailInput: NSTextField!
    @IBOutlet weak var passwordInput: NSTextField!
    
    @IBOutlet weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameInput.placeholderString = "Firstname"
        lastnameInput.placeholderString = "Lastname"
        emailInput.placeholderString = "Email"
        passwordInput.placeholderString = "Password"
    }
    
    func inputsEmpty() -> Bool {
        return !(firstnameInput.stringValue.boolValueFromString && lastnameInput.stringValue.boolValueFromString && emailInput.stringValue.boolValueFromString && passwordInput.stringValue.boolValueFromString)
    }
    
    @IBAction func signupPressed(_ sender: NSButton) {
        signup(firstname: firstnameInput.stringValue, lastname: lastnameInput.stringValue, email: emailInput.stringValue, password: passwordInput.stringValue)
    }
    
    func setErrorMessage(message: String) {
        label.stringValue = message
        label.textColor = .red
    }
    
    func signup(firstname: String, lastname: String, email: String, password: String) {
        let signupParams: Dictionary<String, String> = ["firstname": firstname, "lastname": lastname, "email": email, "password": password]
        if inputsEmpty() {
            setErrorMessage(message: Constants.fieldIsEmpty)
        } else {
            postData(url: Constants.signUpURL, parameters: signupParams) { (result) in
                if (result["error"] as! Bool) {
                    self.setErrorMessage(message: result["requestMessage"] as! String)
                } else {
                    UserDefaults.standard.setValue(result["isAdmin"], forKey: Constants.userIsAdminStorageKey)
                    UserDefaults.standard.setValue(result["zoomLink"], forKey: Constants.userZoomLinkStorageKey)
                    UserDefaults.standard.setValue(result["userId"], forKey: Constants.userIdStorageKey)
                    self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "signupToAccount")
                }
            }
        }
    }

    func transitionControllers(window: NSWindowController?, segueIdentifier: String) {
        guard window != nil else {
            fatalError(Constants.windowControllerDoesNotExist)
        }
        window!.close()
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}

