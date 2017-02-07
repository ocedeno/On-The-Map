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
    
    //Get Multiple Student Locations
    func getStudentLocations (limit: Int, completionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
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
    
    //get Specific Student Location
    func getSpecificStudentLocation (userKeyID: String, completionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            "where" : "{\"uniqueKey\" : \"\(userKeyID)\"}"
        ]
        let url = escapedParameters(parameters)
        let request = NSMutableURLRequest(url: url)
        request.addValue(ParseConstants.parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.parseRestApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        ParseClient.sharedInstance().taskForSession(request: request, completionHandler: completionHandler)
    }
    
    //post User's Location
    func postStudentLocation (userKeyID: String, mapString: String, studentInformation: StudentInformation, completionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void){
        
        let request = NSMutableURLRequest(url: URL(string: ParseRequest.baseURLSecured)!)
        request.httpMethod = "POST"
        request.addValue(ParseConstants.parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.parseRestApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(userKeyID)\", \"firstName\": \"\(studentInformation.firstName)\", \"lastName\": \"\(studentInformation.lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(studentInformation.mediaURL)\",\"latitude\": \(studentInformation.lat), \"longitude\": \(studentInformation.long)}".data(using: String.Encoding.utf8)
        
        ParseClient.sharedInstance().taskForSession(request: request, completionHandler: completionHandler)
    }
}
