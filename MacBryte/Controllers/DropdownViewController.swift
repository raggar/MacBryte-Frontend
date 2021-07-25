//
//  ViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa
import Network
import Combine
import SwiftUI

class DropdownViewController : NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var macbryteEmailText: NSButton!
    @IBOutlet weak var macbryteWebsiteLink: NSButton!
    @IBOutlet weak var internetStatusText: NSTextField!
    @IBOutlet weak var zoomLinkField: NSButton!
    
    @ObservedObject var userEntity: UserEntity = UserEntity.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internetStatusText.stringValue = InternetStatusHandler.shared.getConnectionStatus()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        var zoomLink: String? = userEntity.userData.zoomLink
        
        if zoomLink != "" {
            if zoomLink == Constants.noZoomLink {
                zoomLinkField.title = Constants.noZoomLink
                zoomLinkField.isEnabled = false
            } else {
                zoomLinkField.title = zoomLink!
                zoomLinkField.isEnabled = true
            }
        } else {
            zoomLinkField.title = "Log in to view your Zoom Link"
            zoomLinkField.isEnabled = false
        }
    }

    @IBAction func emailClicked(_ sender: Any) {
        NSPasteboard.general.clearContents();
        NSPasteboard.general.setString(macbryteEmailText.title, forType: .string)
    }
    

    @IBAction func macbryteLinkClicked(_ sender: Any) {
        LinkerService.link(to: Constants.macbryteWebsite)
    }
    
    @IBAction func zoomLinkClicked(_ sender: Any) {
        LinkerService.link(to: zoomLinkField.title)
    }
}
