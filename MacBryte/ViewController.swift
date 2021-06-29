//
//  ViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa
import Network

class ViewController : NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var macbryteEmailText: NSButton!
    @IBOutlet weak var macbryteWebsiteLink: NSButton!
    @IBOutlet weak var zoomLinkTextField: NSTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let zoomLinkValue = UserDefaults.standard.string(forKey: "ZoomLinkKey") {
            zoomLinkTextField.stringValue = zoomLinkValue
        }
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    override func viewWillDisappear() {
        UserDefaults.standard.set(zoomLinkTextField.stringValue, forKey: "ZoomLinkKey")
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
    
    @IBAction func copyToPasteboard(_ sender: NSButton) {
        NSPasteboard.general.clearContents();
        NSPasteboard.general.setString(zoomLinkTextField.stringValue, forType: .string)
    }
}
