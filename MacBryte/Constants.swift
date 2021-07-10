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
    static let menuBarIconInternetGood : String = "BarIcon"
    static let menuBarIconInternetDisconnected : String = "BarIconReversed"
    
    // Internet check
    static let pingHost : String = "https://www.google.com/"
    static let connectedToInternet : String = "You are connected to the internet"
    static let disconnectedFromInternet : String = "You are not connected to the internet"
    
    // Notifications
    static let internetConnectedNotificationTitle = "Internet is Connected"
    static let internetConnectedNotificationBody = "You may now use your computer as normal"
    static let internetDisonnectedNotificationTitle = "Internet is Not Connected"
    static let internetDisconnectedNotificationBody = "Some features on your computer may be unavailable now. Please call MacBryte if this problem persists"
    
    // Error Codes
    static let viewControllerFindFailed = "Unable to find ViewController in the storyboard."
    static let statusItemFindFailed = "Could not find status item button."
}

