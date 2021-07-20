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
    @IBAction func loginPressed(_ sender: NSButton) {
        login(email: emailInput.stringValue, password: passwordInput.stringValue)
    }
    
    @IBAction func signupPressed(_ sender: NSButton) {
        signUp(email: emailInput.stringValue, password: passwordInput.stringValue)
    }
    
    func signUp(email: String, password: String) {
        let signUpParams: [String: String] = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        setData(url: Constants.signUpURL, parameters: signUpParams)
        transitionControllers()
    }
    
    func login(email: String, password: String) {
        let loginParams: [String: String] = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        setData(url: Constants.loginURL, parameters: loginParams)
        transitionControllers()
    }
    
    func transitionControllers() {
        guard let windowController = self.view.window?.windowController else {
            fatalError("Window controller does not exist")
        }
        windowController.close()
        
        performSegue(withIdentifier: "goToTabController", sender: self)
    }
    
    func setData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if (response.result.isSuccess) {
                let responseJSON: JSON = JSON(response.result.value!)
                if (responseJSON["requestStatus"]["error"].rawValue as! Bool) {
                    self.label.stringValue = (responseJSON["requestStatus"]["message"]).rawValue as! String
                    self.label.textColor = .red
                } else {
                    let dataDict: Dictionary<String, Any> = serializeToDict(data: JSON(responseJSON["data"]))
                    if (Constants.enviornment == "production") {
                        UserDefaults.standard.set(true, forKey: "isAuthenticated")
                        UserDefaults.standard.set(dataDict, forKey: "userData")
                    } else {
                        removeUserDefaults()
                    }
                }
            } else {
                print("Error \(String(describing: response.result.error))")
                self.label.stringValue = "Connection issues.."
                self.label.textColor = .red
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        if (UserDefaults.standard.bool(forKey: "isAuthenticated")) {
            transitionControllers()
        }
    }
}
