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

struct UserData {
    var firstName: String
    var lastName: String
    var email: String
    var zoomLink: String
    var packagePurchased: String
    var hoursRemaining: String
    var grandTotalHours: String
}

class UserEntity {
    
    static let shared: UserEntity = UserEntity()
    
    var userData: UserData = UserData(firstName: "", lastName: "", email: "", zoomLink: "", packagePurchased: "", hoursRemaining: "", grandTotalHours: "")
    
    private init() {}
    
    func setUser(user: UserData) -> Void {
        userData = user
    }
}


class LoginViewController: NSViewController, NSTextFieldDelegate {
 
    @IBOutlet weak var emailInput: NSTextField!
    @IBOutlet weak var passwordInput: NSTextField!
    @IBOutlet weak var label: NSTextField!
    
    private var userEntity: UserEntity = UserEntity.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.placeholderString = "Email"
        passwordInput.placeholderString = "Password"
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
    
    func login(email: String, password: String) {
        let loginParams: Dictionary<String, String> = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        if inputsEmpty() {
            setErrorMessage(message: Constants.fieldIsEmpty)
        } else {
            postData(url: Constants.loginURL, parameters: loginParams) { (result) in
                if (result["error"] as! Bool) {
                    self.setErrorMessage(message: result["requestMessage"] as! String)
                } else {
                    print("RESULT", result)
                    UserDefaults.standard.setValue(result["isAdmin"], forKey: Constants.userIsAdminStorageKey)
                    UserDefaults.standard.setValue(result["userId"], forKey: Constants.userIdStorageKey)
                    UserDefaults.standard.setValue(result["zoomLink"], forKey: Constants.userZoomLinkStorageKey)
                    
                    self.getUserInformation()
                }
            }
        }
    }
    
    func getUserInformation() -> Void {
            
        if let userId = UserDefaults.standard.string(forKey: Constants.userIdStorageKey) {
            let getParams: Dictionary<String, String> = ["_id": userId]
                        
            getData(url: Constants.getUserUrl, parameters: getParams) { (result) in
                if result["error"] as! Bool {
                    self.setErrorMessage(message: result["requestMessage"] as! String)
                } else {
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
                        
                    if UserDefaults.standard.bool(forKey: Constants.userIsAdminStorageKey) {
                        self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToAdmin")
                    } else {
                        self.transitionControllers(window: self.view.window?.windowController, segueIdentifier: "loginToAccount")
                    }
                }
            }
        } else {
            print("Could not find id")
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
