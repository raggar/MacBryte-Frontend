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
        super.viewWillAppear()
        
        if let _ = UserDefaults.standard.string(forKey: Constants.userIdStorageKey) {
            if let zoomLink = UserDefaults.standard.string(forKey: Constants.userZoomLinkStorageKey) {
                if zoomLink == "" {
                     self.zoomLinkField.title = Constants.noZoomLink
                     self.zoomLinkField.isEnabled = false
                 } else {
                    self.zoomLinkField.title = zoomLink
                    self.zoomLinkField.isEnabled = true
                 }
            }
        } else {
            self.zoomLinkField.title = "Log in to view your zoom link"
            self.zoomLinkField.isEnabled = false
        }
    }

    @IBAction func emailClicked(_ sender: Any) {
        NSPasteboard.general.clearContents();
        NSPasteboard.general.setString(macbryteEmailText.title, forType: .string)
        
        if let _ = UserDefaults.standard.string(forKey: Constants.userIdStorageKey) {
            self.openAndComposeEmail()
        }
    }
    

    @IBAction func macbryteLinkClicked(_ sender: Any) {
        LinkerService.link(to: Constants.macbryteWebsite)
    }
    
    @IBAction func zoomLinkClicked(_ sender: Any) {
        LinkerService.link(to: zoomLinkField.title)
    }
    
    func openAndComposeEmail() {
         guard let service = NSSharingService(named: NSSharingService.Name.composeEmail) else {
             print("Composing email failed")
             return
         }

         service.recipients = ["info@macbryte.com"]
         service.subject = "MacBryte App: Help Request"
         service.perform(withItems: ["Please delete this placeholder and write your message here"])
     }
}
