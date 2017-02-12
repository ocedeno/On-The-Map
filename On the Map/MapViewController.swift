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
        
        DataModelObject.sharedInstance().universalMapView = mapView
        locationManager.delegate = self
        self.mapClient.updateCurrentLocation(locationManager: locationManager, mapView: DataModelObject.sharedInstance().universalMapView)
        updateMapLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        LoginViewController.sharedInstance().populateData { (result, error) in
            
        }
    }
    
    func updateMapLocations() {
        mapClient.updateStudentLocations(mapView: DataModelObject.sharedInstance().universalMapView, result: DataModelObject.sharedInstance().studArray)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = Utility.sharedInstance().udacityBlue
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
