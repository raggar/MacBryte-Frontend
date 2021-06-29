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
    case InternetDisconnectedButRouterConnected
    case RouterDisconnected
}

class InternetStatusHandler {
    
    static let shared = InternetStatusHandler()
        
    private var routerConnected : Bool = true
    private var internetConnected : Bool = true
    private var connectionStatus : ConnectionStatus?
    
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
        } else if routerConnected && !internetConnected {
            connectionStatus = ConnectionStatus.InternetDisconnectedButRouterConnected
            self.updateMenuBarImage(to: Constants.menuBarIconInternetDown)
        } else if !routerConnected {
            connectionStatus = ConnectionStatus.RouterDisconnected
            self.updateMenuBarImage(to: Constants.menuBarIconRouterNotConnected)
        }
    }
    
    private func updateMenuBarImage(to image: String) {
        DispatchQueue.main.async(execute: {
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.setStatusItemImage(to: image)
        })
    }
}
