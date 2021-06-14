//
//  PingTest.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-14.
//

import Foundation

class PingTest {
    
    let url : URL? = URL(string: "https://www.macbryte.com") // URL we will ping. Replace with IP address(es)
    
    init() {
        // Timer executes pingHost() synchronously
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(PingTest.pingHost), userInfo: nil, repeats: true)
    }
    
    /*
     Pings the url synchronously
     */
    @objc func pingHost() {
        let task = URLSession.shared.dataTask(with: url!) {_, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
        }
        
        task.resume()
    }
}
