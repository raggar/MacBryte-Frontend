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
    
    // Error Codes
    static let notConnectedToInternet : String = "Not connected to internet"
    static let viewControllerFindFailed = "Unable to find ViewController in the storyboard."
    static let statusItemFindFailed = "Could not find status item button."
}

