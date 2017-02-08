//
//  MapViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/15/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: IBOutlets
    @IBOutlet var mapView: MKMapView!
    
    //MARK: Variable/Constants Declarations
    var locationManager = CLLocationManager()
    let mapClient = MapClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        self.mapClient.updateCurrentLocation(locationManager: locationManager, mapView: mapView)
        updateMapLocations()
        
    }
    
    func updateMapLocations() {
        mapClient.updateStudentLocations(mapView: mapView, result: DataModelObject.sharedInstance().studArray)
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> MapViewController {
        struct Singleton {
            static var sharedInstance = MapViewController()
        }
        return Singleton.sharedInstance
    }
}
