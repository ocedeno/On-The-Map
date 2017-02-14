//
//  StudentInformation.swift
//  On the Map
//
//  Created by Octavio Cedeno on 2/3/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    var firstName: String
    var lastName : String
    var mediaURL : String
    var lat : Double
    var long : Double
    
    init(userDict: [String: AnyObject]) {
        
        firstName = userDict["firstName"] as? String ?? ""
        lastName = userDict["lastName"] as? String ?? ""
        mediaURL = userDict["mediaURL"] as? String ?? ""
        lat = userDict["latitude"] as? Double ?? 0.0
        long = userDict["longitude"] as? Double ?? 0.0
    }
    
    static func convertStudentData (array: [[String: AnyObject]]) -> [StudentInformation] {
        
        var studentArray : [StudentInformation] = []
        
        for x in array {
            
            if (x["latitude"] == nil), (x["longitude"] == nil) {
                print("Did not contain a lat/long.")
            } else {
                
                let studElement = StudentInformation(userDict: x)
                studentArray.append(studElement)
            }
        }
        
        return studentArray
    }
}
