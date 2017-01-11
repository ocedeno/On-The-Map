//
//  File.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/6/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation
extension ParseClient {
    
    //MARK: Convenience Methods
    func getStudentLocations (limit: Int, completionHandler: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            "limit" : "\(limit)",
            "order" : "-updatedAt"
        ]
        let url = escapedParameters(parameters)
        let request = NSMutableURLRequest(url: url)
        request.addValue(ParseConstants.parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.parseRestApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        ParseClient.sharedInstance().taskForSession(request: request, completionHandler: completionHandler)
    }
    
    func getSpecificStudentLocation (userKeyID: String, completionHandler: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            "where" : "{\"uniqueKey\" : \"\(userKeyID)\"}"
        ]
        let url = escapedParameters(parameters)
        let request = NSMutableURLRequest(url: url)
        request.addValue(ParseConstants.parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.parseRestApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        ParseClient.sharedInstance().taskForSession(request: request, completionHandler: completionHandler)
    }
    
    func postStudentLocation (userKeyID: String, firstName: String, lastName: String, mapString: String){
        
        let request = NSMutableURLRequest(url: URL(string: ParseRequest.baseURLSecured)!)
        request.httpMethod = "POST"
        request.addValue(ParseConstants.parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.parseRestApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstNAme)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: String.Encoding.utf8)
    }
}
