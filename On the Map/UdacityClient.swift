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
    
    //MARK: Initializers
    
    override init() {
        super.init()
    }
    
    var appDelegate = AppDelegate()
    
    //MARK: Task for Session
    
    func taskForSession(request: NSMutableURLRequest, completionHandler: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        
        //MARK: Starting Session
        let task = appDelegate.session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //GUARD: Handling Error Return
            guard (error == nil) else {
                
                completionHandler(nil, NSError(domain: "On the Map", code: 0, userInfo:  [NSLocalizedDescriptionKey:"There was an error with your request: \(error!)"]))
                return
            }
            
            // GUARD: Response Error Check
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                completionHandler(nil, NSError(domain: "On the Map", code: 0, userInfo: [NSLocalizedDescriptionKey:"Your request returned a status code other than 2xx!"]))
                return
            }
            
            // GUARD: Data Error Check
            guard let data = data else {
                
                completionHandler(nil, NSError(domain: "On the Map", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data was returned by the request!"]))
                
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandler: completionHandler)
            
        }
        task.resume()
    }
    
    //Convert JSON Completion Handler
    private func convertDataWithCompletionHandler(_ data: Data, completionHandler: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject?
        do {
            
            let range = Range(uncheckedBounds: (5, data.count))
            let newData = data.subdata(in: range)
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as AnyObject?
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            print("Data converting found an error.\(NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))")
        }
        
        let userInfoDictionary = parsedResult as! [String:AnyObject]
        
        completionHandler(userInfoDictionary, nil)
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
