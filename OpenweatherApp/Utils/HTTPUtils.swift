//
//  HttpUtils.swift
//  DoodleWeather
//
//  Created by Сергей Морозов on 22.01.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import os.log

// TODO: remove
class HTTPUtils {
    
    static let STATUS_CODE_OK = 200
    
    private init() {}
    
    static func executePOSTRequest(url urlStr: String, with parameters: [String: String], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = createPOSTRequest(url: urlStr, with: parameters)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
    static func executeGETRequest(url urlStr: String, with parameters: [String: String], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = createGETRequest(url: urlStr, with: parameters)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
    static func createPOSTUrlencodedBody(for paramteres: [String:String]) -> String {
        let urlEncoder = UrlEncoder()
        var keyValuePairs: [String] = []
        
        for (key, value) in paramteres {
            let urlEncodedValue = urlEncoder.urlEncode(value)
            let keyValuePair = "\(key)=\(urlEncodedValue)"
            keyValuePairs.append(keyValuePair)
            os_log("keyValuePair: %@", keyValuePair)
        }
        
        let joinedKeyValuePairs = keyValuePairs.joined(separator: "&")
        os_log("joinedKeyValuePairs: %@", joinedKeyValuePairs)
        
        return joinedKeyValuePairs
    }
    
    static func createGETRequest(url urlStr: String, with parameters: [String: String]) -> URLRequest {
        var urlComps = URLComponents(string: urlStr)!
        var queryItems = [URLQueryItem] ()
        
        for (name, val) in parameters {
            let queryItem = URLQueryItem(name: name, value: val)
            queryItems.append(queryItem)
        }
        
        urlComps.queryItems = queryItems
        
        let url = urlComps.url!
        os_log("URL: %@", url.absoluteString)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        return request
    }
    
    static func createPOSTRequest(url urlStr: String, with parameters: [String: String]) -> URLRequest {
        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let postString = HTTPUtils.createPOSTUrlencodedBody(for: parameters)
        request.httpBody = postString.data(using: .utf8)
        
        return request
    }
}
