//
//  Constants.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-11.
//

import Foundation

/*
 Stores all constants in the application for easy maintenance 
 */
class Constants {
    // Emails
    static let macbryteWebsite : String = "https://www.macbryte.com"
    static let macbryteInfoEmail : String = "info@macbryte.com"
    static let defaultHelpEmailSubject : String = "MacBryte App: Help Request"
    static let defaultEmailContent : String = "Please delete this placeholder and write your message here"
    
    // Images
    static let menuBarIcon : String = "BarIcon"
    static let menuBarIconReversed : String = "BarIconReversed"
    
    // Internet check
    static let connectedToInternet : String = "Connected to internet"
    static let notConnectedToInternet : String = "Not connected to internet"
    static let notConnectedToRouter : String = "Not connected to router"
    
    // Error Codes
    static let viewControllerFindFailed = "Unable to find ViewController in the storyboard."
    static let statusItemFindFailed = "Could not find status item button."
}

