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
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Variable/Constants Declarations
    var locationManager = CLLocationManager()
    let mapClient = MapClient()
    let parseClient = ParseClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        self.mapClient.updateCurrentLocation(locationManager: locationManager, mapView: mapView)
        
        ParseClient.sharedInstance().getStudentLocations(limit: 100) {(result, error) in
            
            for i in result! {
                let annotation = MKPointAnnotation()
                annotation.title = i["firstName"] as? String
                annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
                mapView.addAnnotation(annotation)
            }
            
        }
    }
    
    

}
