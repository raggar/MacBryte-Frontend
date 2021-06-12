//
//  ViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa
import Network

class ViewController : NSViewController {
    
    @IBOutlet weak var macbryteEmailText: NSButton!
    @IBOutlet weak var macbryteWebsiteLink: NSButton!
    @IBOutlet weak var contactMacbryteButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        EmailService.sendEmail()
    }
    
    /*
     When website link is pressed, redirects us to the macbryte website
     */
    @IBAction func macbryteLinkClicked(_ sender: Any) {
        LinkerService.link(to: Constants.macbryteWebsite)
    }
    
    /*
     When the "Contact MacBryte" button is pressed open the mail app to compose an email
     */
    @IBAction func contactMacBryte(_ sender: Any) {
        EmailService.sendEmail()
    }
}

