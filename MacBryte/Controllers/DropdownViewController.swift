//
//  ViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa
import Network
import Combine

class DropdownViewController : NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var macbryteEmailText: NSButton!
    @IBOutlet weak var macbryteWebsiteLink: NSButton!
    @IBOutlet weak var internetStatusText: NSTextField!
    @IBOutlet weak var zoomLinkField: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let zoomLinkValue = UserDefaults.standard.string(forKey: Constants.userZoomLinkStorageKey) {
            if "" != zoomLinkValue {
                zoomLinkField.title = zoomLinkValue
            } else {
                zoomLinkField.title = " "
            }
        } else {
            zoomLinkField.title = "Log in to view your Zoom Link"
        }
        
        internetStatusText.stringValue = InternetStatusHandler.shared.getConnectionStatus()
    }

    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    /*
     When the email on the app window is clicked
     */
    @IBAction func emailClicked(_ sender: Any) {
        NSPasteboard.general.clearContents();
        NSPasteboard.general.setString(macbryteEmailText.title, forType: .string)
    }
    
    /*
     When website link is pressed, redirects us to the macbryte website
     */
    @IBAction func macbryteLinkClicked(_ sender: Any) {
        LinkerService.link(to: Constants.macbryteWebsite)
    }
    
    @IBAction func zoomLinkClicked(_ sender: Any) {
        LinkerService.link(to: zoomLinkField.title)
    }
}
