//
//  stringExtensions.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-20.
//

import Foundation

extension String {
    var boolValueFromString: Bool {
        let string = NSString(string: self)
        if (string.length == 0) {
            return false
        } else {
            return true
        }
    }
}
