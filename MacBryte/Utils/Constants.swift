//
//  Constants.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-11.
//

import Foundation

/*
 Stores all constants in the application for easy maintenance
 If repo becomes public DON'T COMMIT this file
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
    static let internetCheckTimeInterval : Double = 2.0
    
    // Notifications
    static let internetConnectedNotificationId : String = "InternetConnectedNotification"
    static let internetConnectedNotificationTitle : String = "Internet is Connected"
    static let internetConnectedNotificationBody : String = "You may now use your computer as normal"
    static let internetDisconnectedNotificationId : String = "InternetDisconnectedNotification"
    static let internetDisconnectedNotificationTitle : String = "Internet is Not Connected"
    static let internetDisconnectedNotificationBody : String = "Some features on your computer may be unavailable. Please call MacBryte if this problem persists"
    
    // Storage Keys
    static let zoomLinkStorageKey : String = "ZoomLinkKey"
    
    // Error Codes
    static let viewControllerFindFailed : String = "Unable to find ViewController in the storyboard."
    static let statusItemFindFailed : String = "Could not find status item button."
    
    // Request Urls
    static let signUpURL : String = "http://localhost:8000/apiV1/signup"
    static let loginURL : String = "http://localhost:8000/apiV1/login"
    static let getUserUrl : String = "http://localhost:8000/apiV1/userInfo"
    
    // Enviornment
    static let enviornment : String = "develop"
}

