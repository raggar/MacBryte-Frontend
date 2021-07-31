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
    static let userIsAdminStorageKey : String = "UserIsAdminKey"
    static let userIdStorageKey : String = "UserIdKey"
    static let userZoomLinkStorageKey : String = "UserZoomLinkKey"
    
    // Error Codes
    static let viewControllerFindFailed : String = "Unable to find ViewController in the storyboard."
    static let statusItemFindFailed : String = "Could not find status item button."
    static let fieldIsEmpty : String = "One or more fields are empty"
    static let windowControllerDoesNotExist = "Window controller does not exist"
    static let userIdNull = "User id is null"
    static let backendMessageNotCompleted = "Unable to complete request"
    static let noZoomLink = "Contact MacBryte to receive a Zoom Link"

    // Editing Interface
    static let savingDataOk = "Successfully saved changes"
    static let defaultStatusText = "Select the values in the table to modify them. You can navigate between cells by using Tab and Shift+Tab. When editing a cell, hit Enter to save changes and Esc to cancel."
    
    
    // Request Urls
    static let signUpURL : String = "http://localhost:8000/apiV1/signup"
    static let loginURL : String = "http://localhost:8000/apiV1/login"
    static let getUserUrl : String = "http://localhost:8000/apiV1/userInfo"
    static let getUsersUrl : String = "http://localhost:8000/apiV1/getAll"
    static let updateUsersUrl : String = "http://localhost:8000/apiV1/updateUsers"
    
    // Enviornment
    static let enviornment : String = "production"
    
    // Sizes
    static let accountViewControllerSize : NSSize = NSSize(width: 500, height: 400)
    static let adminViewControllerSize : NSSize =  NSSize(width: 2000, height: 700)
    static let authenticationTabControllerSize : NSSize = NSSize(width: 500, height: 500)
    
    static let appWindowTitle : String = "MacBryte"
}

