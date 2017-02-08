//
//  ParseClient.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/5/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation

class ParseClient {
    
    var appDelegate = AppDelegate()
    var loginVC = LoginViewController()
    
    //MARK: Error Handling
    
    func sendError(_ errorMessage: String) {
        print("\(errorMessage)")
    }

    //MARK: Task for Session
    
    func taskForSession(request: NSMutableURLRequest, completionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
        //MARK: Starting Session
        let task = appDelegate.session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //GUARD: Handling Error Return
            guard (error == nil) else {
                self.sendError("***There was an error with your request: \(error!)")
                return
            }
            
            // GUARD: Response Error Check (Login Verified)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
               
                self.sendError("***Your request returned a status code other than 2xx! \(response!)")
                return
            }
            
            // GUARD: Data Error Check
            guard let data = data else {
                self.sendError("***No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandler: completionHandler)
        }
        task.resume()
    }
    
    //Convert JSON Completion Handler
    private func convertDataWithCompletionHandler(_ data: Data, completionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject?
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject?
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            sendError("***Data converting found an error.\(NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))")
        }
        
        let result = parsedResult as! [String:AnyObject]
        let arrayOfUserDic = result["results"]
        
        completionHandler(arrayOfUserDic as! [[String : AnyObject]]?, nil)
        
    }
    
    
    //MARK: Shared Instance
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
    //MARK: Escaping ASCII Characters 
    func escapedParameters (_ parameters: [String:String]) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "parse.udacity.com"
        components.path = "/parse/classes/StudentLocation"
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
}
