//
//  UdacityConvenience.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/3/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation
extension UdacityClient {

    //MARK: Building Request for Udacity Authorization
    func udacityAuthenticationRequest(username: String, password: String, completionHandler: @escaping (_ result: AnyObject?, _ error: Error?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\":{\"username\":\"\(username)\",\"password\":\"\(password)\"}}".data(using: String.Encoding.utf8)
                
        taskForSession(request: request, completionHandler: completionHandler)
    }
    
    //MARK: Building Request for Udacity Logout
    func udacityLogoutRequest(completionHandler: @escaping (_ result: AnyObject?, _ error: Error?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        taskForSession(request: request, completionHandler: completionHandler)
    
    }
}
