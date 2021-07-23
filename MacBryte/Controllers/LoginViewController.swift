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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.placeholderString = "Email"
        passwordInput.placeholderString = "Password"
    }
 
    @IBOutlet weak var emailInput: NSTextField!
    @IBOutlet weak var passwordInput: NSTextField!
    @IBOutlet weak var label: NSTextField!
    
    @IBAction func loginPressed(_ sender: NSButton) {
        DispatchQueue.main.async {
            self.login(email: self.emailInput.stringValue, password: self.passwordInput.stringValue)
        }
    }
    
    func setErrorMessage(message: String) {
        label.stringValue = message
        label.textColor = .red
    }
    
    func inputsEmpty() -> Bool {
        return !(emailInput.stringValue.boolValueFromString && passwordInput.stringValue.boolValueFromString)
    }
    
    func login(email: String, password: String) {
        let loginParams: Dictionary<String, String> = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        if inputsEmpty() {
            setErrorMessage(message: "One or more fields are empty")
        } else {
            fetchData(url: Constants.loginURL, parameters: loginParams) { (result) in
                if (result["error"] as! Bool) {
                    self.setErrorMessage(message: result["requestMessage"] as! String)
                } else {
                    UserDefaults.standard.setValue(result["isAdmin"], forKey: "isAdmin")
                    UserDefaults.standard.setValue(result["userId"], forKey: "userId")
                    self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToDataController")
                }
            }
        }
    }

    func transitionControllers(window: NSWindowController?, segueIdentifier: String) {
        guard window != nil else {
            fatalError("Window controller does not exist")
        }
        window!.close()
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}
