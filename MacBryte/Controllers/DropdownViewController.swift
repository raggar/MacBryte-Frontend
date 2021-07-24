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
        internetStatusText.stringValue = InternetStatusHandler.shared.getConnectionStatus()
    }
    
    override func viewWillAppear() {
        let zoomLink = UserDefaults.standard.string(forKey: Constants.userZoomLinkStorageKey)
        if zoomLink != nil {
            if (zoomLink == "") {
                zoomLinkField.isHidden = true
            } else {
                zoomLinkField.title = zoomLink!
            }
        } else {
            zoomLinkField.title = "Log in to view your Zoom Link"
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
