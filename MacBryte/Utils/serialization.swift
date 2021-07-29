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
        } else if key == "users" {
            let userRawData = data[key].array
            let usersArray: [User] = userRawData!.map { (user) -> User in
                let userId: String = user["userId"].rawValue as! String
                let firstname: String = user["firstname"].rawValue as! String
                let lastname : String = user["lastname"].rawValue as! String
                let email: String = user["email"].rawValue as! String
                let password: String = user["password"].rawValue as! String
                let zoomLink: String = user["zoomLink"].rawValue as! String
                let packagePurchased: String = user["packagePurchased"].rawValue as! String
                let grandTotalHours : Int = user["grandTotalHours"].rawValue as! Int
                let hoursRemaining: Int = user["hoursRemaining"].rawValue as! Int
                let dateOfEntry: String = user["dateOfEntry"].rawValue as! String
                //let isAdmin: Bool = user["isAdmin"].rawValue as! Bool
                return User(userId: userId, firstname: firstname, lastname: lastname, email: email, password: password, zoomLink: zoomLink, packagePurchased: packagePurchased, hoursRemaining: hoursRemaining, grandTotalHours: grandTotalHours, dateOfEntry: dateOfEntry)
                }
            serializedDic[key] = usersArray
        }
        else {
            serializedDic[key] = (data[key]).rawValue as! String
        }
    }
    return serializedDic
}
