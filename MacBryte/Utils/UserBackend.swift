//
//  setData.swift
//  MacBryte
//
//  Created by Rahul Aggarwal on 2021-07-20.
//

import Foundation
import Alamofire
import SwiftyJSON

func fetchData(url: String, parameters: [String: String], completionHandler: @escaping ((Dictionary<String, Any>) -> Void)) {
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        let result: Dictionary<String, Any>
        if (response.result.isSuccess) {
            result = serializeToDict(data: JSON(response.result.value!))
            completionHandler(result)
        } else {
            result = ["error": true, "requestMessage": Constants.backendMessageNotCompleted]
        }
        completionHandler(result)
    }
}

func getData(url: String, parameters: [String: String], completionHandler: @escaping ((Dictionary<String, Any>) -> Void)) {
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
        response in
        
        let result: Dictionary<String, Any>
        if response.result.isSuccess {
            result = serializeToDict(data: JSON(response.result.value))
            completionHandler(result)
        } else {
            result = ["error": true, "requestMessage": Constants.backendMessageNotCompleted]
        }
        
        completionHandler(result)
    }
}
