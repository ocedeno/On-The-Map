//
//  UdacityConstants.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/20/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

extension UdacityClient {
    
    // MARK: Method Keys
    struct MethodKeys {
        static let postMethod = "https://www.udacity.com/api/session"
    }
    
    //MARK: Method Type
    struct methodType {
        static let post = "POST"
        static let delete = "DELETE"
    }
    
    //MARK: Parameters
    struct MethodParameters {
        static var udacityDictionary : [String:String] = [:]
        static var username: String? = ""
        static var userPassword: String? = ""
    }
    
    //MARK: JSONResponseKeys
    struct JSONResponseKeys {
        
        //MARK: General
        static let account = "account"
        static let session = "session"
        
        //MARK: Account
        static let registered = "registered"
        static let key = "key"
        
        //MARK: Session
        static let id = "id"
        static let expiration = "expiration"
    }
    
}
