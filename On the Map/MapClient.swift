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
    
    func updateCurrentLocation(locationManager: CLLocationManager, mapView: MKMapView) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            
            guard let lat: CLLocationDegrees = locationManager.location?.coordinate.latitude, let lon: CLLocationDegrees = locationManager.location?.coordinate.longitude else {
                print("No Lat/Lon was found")
                return
            }
            
            let latDelta: CLLocationDegrees = 0.5
            let lonDelta: CLLocationDegrees = 0.5
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2DMake(lat, lon)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
}
