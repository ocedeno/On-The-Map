//
//  MapClient.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/15/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapClient {
    
    var locationManager: CLLocationManager!
    
    func updateCurrentLocation(mapView: MKMapView) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            
            
        }
    }
    
}
