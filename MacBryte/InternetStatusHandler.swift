//
//  InternetStatusHandler.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-14.
//

import Foundation
import Cocoa

class InternetStatusHandler {
    enum ConnectionStatus {
        case Connected
        case InternetDisconnectedButRouterConnected
        case RouterDisconnected
    }
    
    static let shared = InternetStatusHandler()
    
    private var routerConnected : Bool = true
    private var internetConnected : Bool = true
    private var connectionStatus : ConnectionStatus?
    private var timerStarted : Bool = false
    
    private init() {}
    
    public func displayConnectionResults() {
        // Only start timer once
        if !timerStarted {
            Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true) { timer in
                self.determineConnectionResults()
            }
        }
    }

    public func setRouterConnectionStatus(to status: Bool) {
        routerConnected = status
    }
    
    public func setInternetConnected(to status: Bool) {
        internetConnected = status
    }
    
    private func determineConnectionResults() {
        if routerConnected && internetConnected {
            self.updateMenuBarImage(to: Constants.menuBarIconInternetGood)
        } else if routerConnected && !internetConnected {
            self.updateMenuBarImage(to: Constants.menuBarIconInternetDown)
        } else if !routerConnected {
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
