//
//  NetworkMonitor.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-10.
//

import Foundation
import Network
import Cocoa

final class RouterConnectionService {
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    enum RouterConnectionStatus {
        case connected
        case disconnected
    }
    
    static let shared = RouterConnectionService()
    
    private let queue = DispatchQueue.global() // concurrently handles system thread actions
    private let monitor: NWPathMonitor = NWPathMonitor() // observer that monitors and reacts to network changes
    private var timerStarted : Bool = false
    private var routerConnectionTimer : Timer? = nil

    // private set means that public can access but can't set 
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType?
    public private(set) var routerConnectionStatus: RouterConnectionStatus?
    
    private init() {}
    
    public func startMeasuring() {
        // Only start timer once
        if !timerStarted {
            startMonitoring()
            
            // Executes code every 7 seconds
            routerConnectionTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                if (self.isConnected) { // We are connected to the router
                    if .connected != self.routerConnectionStatus {
                        InternetStatusHandler.shared.setRouterConnectionStatus(to: true)
                        self.routerConnectionStatus = .connected
                    }
                } else {// We are not connected to the router
                    if .disconnected != self.routerConnectionStatus {
                        InternetStatusHandler.shared.setRouterConnectionStatus(to: false)
                        self.routerConnectionStatus = .disconnected
                    }
                }
            }
        }
    }
    
    private func startMonitoring() {
        monitor.start(queue: queue)
        // recieve networth path updates
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path: path)
        }
    }
    
    private func stopMonitoring() {
        timerStarted = false;
        
        // End timer
        routerConnectionTimer!.invalidate()
        routerConnectionTimer = nil
        
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
}
