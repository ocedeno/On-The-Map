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
        
        if let x = userDict["firstName"] {
            firstName = x as! String
        } else {
            print("No first name found")
            firstName = " "
        }
        
        if let x = userDict["lastName"] {
            lastName = x as! String
        } else {
            print("No last name found")
            lastName = " "
        }
        
        if let x = userDict["mediaURL"] {
            mediaURL = x as! String
        } else {
            print("No mediaURL found")
            mediaURL = " "
        }
        
        if let x = userDict["latitude"] {
            lat = x as! Double
        } else {
            print("No latitude found")
            lat = 0.0
        }
        
        if let x = userDict["longitude"] {
            long = x as! Double
        } else{
            print("No longitude found")
            long = 0.0
        }
        
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
