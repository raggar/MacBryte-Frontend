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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameValue = UserDefaults.standard.string(forKey: Constants.userIdStorageKey) {
            nameField.stringValue = nameValue
        }

    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    
}

