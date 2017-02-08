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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
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
    
    
    //MARK:
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: toOpen)!)
            }
        }
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> MapViewController {
        struct Singleton {
            static var sharedInstance = MapViewController()
        }
        return Singleton.sharedInstance
    }
}
