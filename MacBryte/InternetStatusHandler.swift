//
//  InternetStatusHandler.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-14.
//

import Foundation
import Cocoa

enum ConnectionStatus {
    case Connected
    case Disconnected
}

class InternetStatusHandler {
    
    static let shared = InternetStatusHandler()
    
    private var notificationHandler = NotificationHandler.shared
        
    private var routerConnected : Bool = true
    private var internetConnected : Bool = true
    private var connectionStatus : ConnectionStatus = ConnectionStatus.Connected { // Sends notification only if variable has been reinitialized
        didSet {
            if oldValue != connectionStatus { // Only trigger notification if internet status has changed
                NotificationHandler.shared.getNotificationAuthorization() // Get authorization. This prevents bug where first notification does not send
                
                if ConnectionStatus.Connected == connectionStatus {
                    notificationHandler.displayNotification(for: Constants.internetConnectedNotificationTitle, with: Constants.internetConnectedNotificationBody)
                } else {
                    notificationHandler.displayNotification(for: Constants.internetDisonnectedNotificationTitle, with: Constants.internetDisconnectedNotificationBody)
                }
            }
        }
    }
    
    private init() {}

    public func setRouterConnectionStatus(to status: Bool) {
        routerConnected = status
        
        determineConnectionResults() // Determine connection result when status is updated
    }
    
    public func setInternetConnected(to status: Bool) {
        internetConnected = status
        
        determineConnectionResults() // Determine connection result when status is updated
    }
    
    private func determineConnectionResults() {
        if routerConnected && internetConnected {
            connectionStatus = ConnectionStatus.Connected
            self.updateMenuBarImage(to: Constants.menuBarIconInternetGood)
        } else {
            connectionStatus = ConnectionStatus.Disconnected
            self.updateMenuBarImage(to: Constants.menuBarIconInternetDisconnected)
        }
    }
    
    private func updateMenuBarImage(to image: String) {
        DispatchQueue.main.async(execute: {
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.setStatusItemImage(to: image)
        })
    }
    
    public func getConnectionStatus() -> String {
        if ConnectionStatus.Connected == connectionStatus {
            return Constants.connectedToInternet
        } else {
            return Constants.disconnectedFromInternet
        }
    }
}
