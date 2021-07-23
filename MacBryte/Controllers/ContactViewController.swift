//
//  ContactViewController.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-07-21.
//

import Cocoa
import Network
import Combine

class ContactViewController : NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var emailLink: NSButton!
    @IBOutlet weak var websiteLink: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    /*
     When the email on the app window is clicked
     */
    @IBAction func emailClicked(_ sender: Any) {
        print("Here")
        NSPasteboard.general.clearContents();
        NSPasteboard.general.setString(emailLink.title, forType: .string)
    }
    
    /*
     When website link is pressed, redirects us to the macbryte website
     */
    @IBAction func macbryteLinkClicked(_ sender: Any) {
        print("Here11111")
        LinkerService.link(to: Constants.macbryteWebsite)
    }
}
