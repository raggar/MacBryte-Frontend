//
//  DataTabViewController.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-21.
//

import Cocoa

class DataTabViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userId = UserDefaults.standard.string(forKey: Constants.userIdStorageKey
        ) else {
            fatalError(Constants.userIdNull)
        }
        fetchData(url: Constants.getUserUrl, parameters: ["userId": userId]) { result in
            print("RESULT", result)
        }
    }
    
}
