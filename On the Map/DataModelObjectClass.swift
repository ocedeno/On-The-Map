//
//  DataModelObjectClass.swift
//  On the Map
//
//  Created by Octavio Cedeno on 2/8/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation
import MapKit

class DataModelObject {
    
    var studArray = [StudentInformation]()
    var userInfo = [String:AnyObject]()
    var currentUserLat = 0.0
    var currentUserLon = 0.0
    var currentUserKeyID : String?
    var universalMapView : MKMapView!
    var secondaryUniversalMapView : MKMapView!
    
    //MARK: Shared Instance
    class func sharedInstance() -> DataModelObject {
        struct Singleton {
            static var sharedInstance = DataModelObject()
        }
        return Singleton.sharedInstance
    }
}
