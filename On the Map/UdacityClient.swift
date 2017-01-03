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
    
    //MARK: Task for Session
    
    func taskForSession(request: NSMutableURLRequest, completionHandler: @escaping (_ result: AnyObject?, _ error: Error?) -> Void) -> URLSessionDataTask {
     
        //MARK: Starting Session
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //MARK: Error Handling
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandler(nil, NSError(domain: "taskForUdacityAuthentication", code: 1, userInfo: userInfo))
            }
            
            //GUARD: Handling Error Return
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            // GUARD: Response Error Check
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx! \(response!)")
                return
            }
            
            // GUARD: Data Error Check
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }

            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
            
        }
        task.resume()
        return task
    }
    
    //Convert JSON Completion Handler
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject?
        do {
            
            let range = Range(uncheckedBounds: (5, data.count))
            let newData = data.subdata(in: range)
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as AnyObject?
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
            print("Data converting found an error. \(error)")
        }

        completionHandlerForConvertData(parsedResult, nil)

    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
