//
//  LoginViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-17.
//

import Foundation
import Cocoa
import Network
import Alamofire
import SwiftyJSON

class LoginViewController: NSViewController, NSTextFieldDelegate {
 
    @IBOutlet weak var emailInput: NSTextField!
    @IBOutlet weak var passwordInput: NSTextField!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var loginButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.placeholderString = "Email"
        passwordInput.placeholderString = "Password"
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        emailInput.becomeFirstResponder()
    }
    
    @IBAction func loginPressed(_ sender: NSButton) {
        self.login(email: self.emailInput.stringValue, password: self.passwordInput.stringValue)
    }
    
    func setErrorMessage(message: String) {
        label.stringValue = message
        label.textColor = .red
    }
    
    func inputsEmpty() -> Bool {
        return !(emailInput.stringValue.boolValueFromString && passwordInput.stringValue.boolValueFromString)
    }
    
    @IBAction func textFieldAction(sender: NSTextField) {
        let identifier = sender.identifier!.rawValue
        if (identifier == "loginEmailInput") {
            passwordInput.becomeFirstResponder()
        } else {
            login(email: emailInput.stringValue, password: passwordInput.stringValue)
        }
    }
    
    func login(email: String, password: String) {
        loginButton.isEnabled = false
        let loginParams: Dictionary<String, String> = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        if inputsEmpty() {
            setErrorMessage(message: Constants.fieldIsEmpty)
            loginButton.isEnabled = true
        } else {
            postData(url: Constants.loginURL, parameters: loginParams) { (result) in
                if (result["error"] as! Bool) {
                    self.setErrorMessage(message: result["requestMessage"] as! String)
                    self.loginButton.isEnabled = true
                } else {
                    UserDefaults.standard.setValue(result["isAdmin"], forKey: Constants.userIsAdminStorageKey)
                    UserDefaults.standard.setValue(result["userId"], forKey: Constants.userIdStorageKey)
                    UserDefaults.standard.setValue(result["zoomLink"], forKey: Constants.userZoomLinkStorageKey)
                    if (UserDefaults.standard.bool(forKey: Constants.userIsAdminStorageKey)) {
                        self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToAdmin")
                    } else {
                        self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToAccount")
                    }
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
