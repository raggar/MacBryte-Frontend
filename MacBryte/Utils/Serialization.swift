//
//  Serialization.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-17.
//

import Foundation
import SwiftyJSON

func serializeToDict(data: JSON) -> Dictionary<String, Any> {
    var new_dict = [String: Any]()
    
    for (key, _) in data {
        if (key == "hoursRemaining" || key == "grandTotalHours") {
            new_dict[key] = (data[key]).rawValue as! Int
        } else if key == "previousSessionSummary" {
            new_dict[key] = (data[key]).rawValue as! [String]
        } else {
            new_dict[key] = (data[key]).rawValue as! String
        }
    }
    return new_dict
}

func removeUserDefaults() {
    if let bundleID = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
}
