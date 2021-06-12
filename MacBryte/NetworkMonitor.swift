//
//  NetworkMonitor.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-06-10.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global() // concurrently handles system thread actions
    private let monitor: NWPathMonitor // observer that monitors and reacts to network changes

    // private set means that public can access but can't set 
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType?
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    init() {
        monitor = NWPathMonitor()
        startMonitoring()
        Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true) { timer in
            if (self.isConnected) {
                print("Connected to", self.connectionType!)
            } else {
                print("Not connected to internet")
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
}
