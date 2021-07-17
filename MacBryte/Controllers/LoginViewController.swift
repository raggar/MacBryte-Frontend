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
        Alamofire.request(Constants.signUpURL, method: .post, parameters: signUpParams, encoding: JSONEncoding.default).responseJSON { response in
            if (response.result.isSuccess) {
                let responseJSON: JSON = JSON(response.result.value!)
                if (responseJSON["requestStatus"]["error"].rawValue as! Bool) {
                    self.label.stringValue = (responseJSON["requestStatus"]).rawValue as! String
                } else {
                    let dataDict: Dictionary<String, Any> = serializeToDict(data: JSON(responseJSON["data"]))
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(dataDict, forKey: "userData")
                    // perform segue
                }
            } else {
                print("Error \(String(describing: response.result.error))")
                self.label.stringValue = "Connection issues.."
            }
        }
    }
    
    func login(email: String, password: String) {
        let loginParams: [String: String] = ["email": emailInput.stringValue, "password": passwordInput.stringValue]
        Alamofire.request(Constants.loginURL, method: .post, parameters: loginParams, encoding: JSONEncoding.default).responseJSON { response in
            if (response.result.isSuccess) {
                let responseJSON: JSON = JSON(response.result.value!)
                if (responseJSON["requestStatus"]["error"].rawValue as! Bool) {
                    self.label.stringValue = (responseJSON["requestStatus"]).rawValue as! String
                } else {
                    let dataDict: Dictionary<String, Any> = serializeToDict(data: JSON(responseJSON["data"]))
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(dataDict, forKey: "userData")
                    // perform segue
                }
            } else {
                print("Error \(String(describing: response.result.error))")
                self.label.stringValue = "Connection issues.."
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        if (isAuthenticated) {
            print("User is currently logged in")
//            performSegue(withIdentifier: <#T##NSStoryboardSegue.Identifier#>, sender: <#T##Any?#>)
        }
    }
}
