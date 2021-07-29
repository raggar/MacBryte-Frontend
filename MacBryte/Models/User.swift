//
//  User.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-27.
//

import Foundation

class User: NSObject {
    @objc dynamic var userId: String
    @objc dynamic var firstname: String
    @objc dynamic var lastname: String
    @objc dynamic var email: String
    @objc dynamic var password: String
    @objc dynamic var zoomLink: String
    @objc dynamic var packagePurchased: String
    @objc dynamic var hoursRemaining: Int
    @objc dynamic var grandTotalHours: Int
    @objc dynamic var dateOfEntry: String
    
    init(userId: String, firstname: String, lastname: String, email: String, password: String, zoomLink: String, packagePurchased: String, hoursRemaining: Int, grandTotalHours: Int, dateOfEntry: String ) {
        self.userId = userId
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.zoomLink = zoomLink
        self.packagePurchased = packagePurchased
        self.hoursRemaining = hoursRemaining
        self.grandTotalHours = grandTotalHours
        self.dateOfEntry = dateOfEntry
    }
    
    // convert swift class to dictionary
    var asDictionary : [String:Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}
