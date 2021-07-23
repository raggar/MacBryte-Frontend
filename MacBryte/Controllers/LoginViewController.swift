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
        print(emailInput.stringValue)
        print("INPUTS EMPTY",emailInput.stringValue.boolValueFromString, passwordInput.stringValue.boolValueFromString)
        return !(emailInput.stringValue.boolValueFromString && passwordInput.stringValue.boolValueFromString)
    }
    
    func login(email: String, password: String) {
        let loginParams: Dictionary<String, String> = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        if inputsEmpty() {
            setErrorMessage(message: "One or more fields are empty")
        } else {
            var data: Dictionary<String, Any> = fetchData(url: Constants.loginURL, parameters: loginParams)
            print(data)
//            print(data["error"] as! Bool)
//            if (data["error"] as! Bool) {
//                setErrorMessage(message: data["requestMessage"] as! String)
//            } else {
//                UserDefaults.standard.setValue(data["isAdmin"], forKey: "isAdmin")
//                UserDefaults.standard.setValue(data["userId"], forKey: "userId")
//                transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToDataController")
//            }
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
