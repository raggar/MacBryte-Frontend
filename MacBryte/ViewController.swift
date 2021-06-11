//
//  ViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa
import Network

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkMonitor.shared.isConnected {
            print("You're connected")
        } else {
            print(" You're not connected.")
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    /*
     When the email on the app window is clicked
     */
    @IBAction func emailClicked(_ sender: Any) {
        openAndComposeEmail()
    }
    
    /*
     When website link is pressed, redirects us to the macbryte website
     */
    @IBAction func macbryteLinkClicked(_ sender: Any) {
        if let url = URL(string: "https://www.macbryte.com") {
            NSWorkspace.shared.open(url)
        }
    }
    
    /*
     When the "Contact MacBryte" button is pressed open the mail app to compose an email
     */
    @IBAction func contactMacBryte(_ sender: Any) {
        openAndComposeEmail()
    }
    
    func openAndComposeEmail() {
        guard let service = NSSharingService(named: NSSharingService.Name.composeEmail) else {
            print("Composing email failed")
            return
        }
        print("Hello")
        service.recipients = ["rahul@macbryte.com", "dhruv@macbryte.com"]
        service.subject = "MacBryte App: Help Request"
        service.perform(withItems: ["Please delete this placeholder and write your message here"])
    }
}

