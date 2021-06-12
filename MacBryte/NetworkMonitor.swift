//
//  NetworkMonitor.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-10.
//

import Foundation
import Network
import Cocoa

final class NetworkMonitor {
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    enum ConnectionStatus {
        case connected
        case disconnected
    }
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global() // concurrently handles system thread actions
    private let monitor: NWPathMonitor // observer that monitors and reacts to network changes

    // private set means that public can access but can't set 
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType?
    public private(set) var connectionStatus: ConnectionStatus?
    
    
    
    init() {
        monitor = NWPathMonitor()
        startMonitoring()
        
        // Executes code every 7 seconds
        Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true) { timer in
            if (self.isConnected) {
                if .connected != self.connectionStatus {
                    self.updateMenuBarImage(to: Constants.menuBarIcon)
                    self.connectionStatus = .connected
                }
                
                print("Connected to", self.connectionType!)
            } else {
                if .disconnected != self.connectionStatus {
                    self.updateMenuBarImage(to: Constants.menuBarIconReversed)
                    self.connectionStatus = .disconnected
                }
                
                print(Constants.notConnectedToInternet)
            }
        }
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        // recieve networth path updates
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path: path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    private func updateMenuBarImage(to image: String) {
        DispatchQueue.main.async(execute: {
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.setStatusItemImage(to: image)
        })
    }
}
