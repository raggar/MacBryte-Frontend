//
//  PingTest.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-14.
//

import Foundation

class InternetConnectionService {
    
    
    static let shared = InternetConnectionService()
    
    private let url : URL? = URL(string: Constants.macbryteWebsite) // URL we will ping. Replace with IP address(es)
    private var timerStarted : Bool = false
    
    private init() {}
    
    public func startMeasuring() {
        // Only start timer once
        if !timerStarted {
            // Timer executes pingHost() synchronously
            Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(InternetConnectionService.pingHost), userInfo: nil, repeats: true)
        }
    }
    
    
    /*
     Pings the url synchronously
     */
    @objc func pingHost() {
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
            if let response = response {
                print(Constants.connectedToInternet)
            }
            
            if let error = error {
                print(Constants.notConnectedToInternet)
            }
        })
        
        task.resume()
    }
}
