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
import AddressBookUI

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
    
    func updateStudentLocations(mapView: MKMapView, result: [StudentInformation]) {
        
        for x in result {
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(x.firstName) \(x.lastName)"
            annotation.subtitle = x.mediaURL
            let latitude : CLLocationDegrees = CLLocationDegrees(exactly: x.lat)!
            let longitude : CLLocationDegrees = CLLocationDegrees(exactly: x.long)!
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func forwardGeocoding(address: String, mapView: MKMapView) {
        
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            
            guard (error == nil), let _ = placemarks else {
                print("There was an issue finding that location. \(error)")
                return
            }
            
            let placemark = placemarks?[0]
            let userLocation = placemark?.location
            let coordinate = userLocation?.coordinate
            
            let annotation = MKPointAnnotation()
            let latitude : CLLocationDegrees = CLLocationDegrees(exactly: coordinate!.latitude)!
            let longitude : CLLocationDegrees = CLLocationDegrees(exactly: coordinate!.longitude)!
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            annotation.title = address
            mapView.addAnnotation(annotation)
            
            let latDelta: CLLocationDegrees = 0.5
            let lonDelta: CLLocationDegrees = 0.5
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2DMake(latitude, longitude)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            DataModelObject.sharedInstance().currentUserLat = latitude
            DataModelObject.sharedInstance().currentUserLon = longitude
        })
    }
    
    func centralizeLocations (lat: Double, lon: Double, mapView: MKMapView) {
        
        let latDelta: CLLocationDegrees = 0.5
        let lonDelta: CLLocationDegrees = 0.5
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2DMake(lat, lon)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
}
