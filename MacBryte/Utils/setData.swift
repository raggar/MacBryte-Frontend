//
//  setData.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-20.
//

import Foundation
import Alamofire
import SwiftyJSON



func fetchData(url: String, parameters: [String: String]) {
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        let resultDic: Dictionary<String, Any>;
        if (response.result.isSuccess) {
            let responseJSON: JSON = JSON(response.result.value!)
            resultDic = serializeToDict(data: JSON(responseJSON))
            
        } else {
            resultDic["error"] = true
            resultDic["message"] = "Unable to complete request"
        }
    }
}
