//
//  AppDelegate.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa
import Network

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setStatusItemImage(to: Constants.menuBarIconInternetGood)
        
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showPopup)
        
        RouterConnectionService.shared.startMeasuring()
        InternetConnectionService.shared.startMeasuring()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    @objc func showPopup() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)

        guard let vc = storyboard.instantiateController(withIdentifier: "ViewController") as? ViewController else {
            fatalError(Constants.viewControllerFindFailed)
        }

        guard let button = statusItem.button else {
            fatalError(Constants.statusItemFindFailed)
        }

        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient // when user clicks away popup will close itself
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY) // show popup "relative" to menu item icon
    }
    
    func setStatusItemImage(to image: String) {
        let itemImage = NSImage(named: image)
        statusItem.button?.image = itemImage
    }
}

