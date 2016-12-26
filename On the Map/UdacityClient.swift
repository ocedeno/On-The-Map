//
//  UdacityClients.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/20/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

import Foundation

// MARK: - UdacityClient: NSObject

class UdacityClient: NSObject {
    
    // MARK: Properties
    
    //shared session
    var session = URLSession.shared
    
    //authentication state
    var sessionID : String? = nil
    
    //MARK: Initializers
    
    override init() {
        super.init()
    }
    
    //MARK: POST
    
    func taskForPOSTMethod(_ method: String, parameters: [String: String], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
     
        //MARK: Setting Parameters
        UdacityClient.MethodParameters.username = parameters["username"]
        UdacityClient.MethodParameters.userPassword = parameters["password"]
        
        
    }
    
}
