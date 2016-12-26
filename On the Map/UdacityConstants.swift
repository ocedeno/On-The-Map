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
        static let NewSession = "https://www.udacity.com/api/session"
    }
    
    //MARK: Method Type
    struct MethodType {
        static let Post = "POST"
        static let Delete = "DELETE"
    }
    
    //MARK: Parameters
    struct MethodParameters {
        static var UdacityDictionary : [String:String] = [:]
        static var Username: String? = ""
        static var UserPassword: String? = ""
    }
    
    //MARK: Request Values
    struct RequestValues {
        static let AppJSON = "application/json"
        static let AcceptHeader = "Accept"
        static let ContentTypeHeader = "Content-Type"
    }
    
    //MARK: JSONResponseKeys
    struct JSONResponseKeys {
        
        //MARK: General
        static let Account = "account"
        static let Session = "session"
        
        //MARK: Account
        static let Registered = "registered"
        static let Key = "key"
        
        //MARK: Session
        static let Id = "id"
        static let Expiration = "expiration"
    }
    
}
