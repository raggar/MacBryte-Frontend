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
            setErrorMessage(message: Constants.fieldIsEmpty)
        } else {
            fetchData(url: Constants.loginURL, parameters: loginParams) { (result) in
                if (result["error"] as! Bool) {
                    self.setErrorMessage(message: result["requestMessage"] as! String)
                } else {
                    print(result)
                    UserDefaults.standard.setValue(result["isAdmin"], forKey: Constants.userIsAdminStorageKey)
                    UserDefaults.standard.setValue(result["userId"], forKey: Constants.userIdStorageKey)
                    UserDefaults.standard.setValue(result["firstname"], forKey: Constants.userFirstNameStorageKey)
                    UserDefaults.standard.setValue(result["lastname"], forKey: Constants.userLastNameStorageKey)
                    UserDefaults.standard.setValue(result["email"], forKey: Constants.userEmailStorageKey)
                    UserDefaults.standard.setValue(result["zoomLink"], forKey: Constants.userZoomLinkStorageKey)
                    UserDefaults.standard.setValue(result["packagePurchased"], forKey: Constants.userPackagePurchasedStorageKey)
                    UserDefaults.standard.setValue(result["hoursRemaining"], forKey: Constants.userHoursRemainingStorageKey)
                    UserDefaults.standard.setValue(result["grandTotalHours"], forKey: Constants.userGrandTotalHoursStorageKey)
                    
                    self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToDataController")
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
