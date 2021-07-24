//
//  Serialization.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-17.
//

import Foundation
import SwiftyJSON

let integerKeys: [String] = ["hoursRemaining", "grandTotalHours"]
let booleanKeys: [String] = ["error", "isAdmin"]

func serializeToDict(data: JSON) -> Dictionary<String, Any> {
    var serializedDic = [String: Any]()
    for (key, _) in data {
        if integerKeys.contains(key) {
            serializedDic[key] = (data[key]).rawValue as! Int
        } else if booleanKeys.contains(key) {
            serializedDic[key] = (data[key]).rawValue as! Bool
        } else {
            serializedDic[key] = (data[key]).rawValue as! String
        }
    }
    return serializedDic
}
