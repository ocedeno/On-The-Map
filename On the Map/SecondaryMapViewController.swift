//
//  SecondaryMapViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 2/10/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit
import MapKit

class SecondaryMapViewController: UIViewController {
    
    @IBOutlet var secondaryMapView: MKMapView!
    let mapClient = MapClient()
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeView()
    }
    
    func initializeView() {
        
        let studArray = DataModelObject.sharedInstance().studArray[row]
        
        mapClient.centralizeLocations(lat: studArray.lat, lon: studArray.long, mapView: secondaryMapView)
        let annotation = MKPointAnnotation()
        annotation.title = "\(studArray.firstName) \(studArray.lastName)"
        annotation.subtitle = "\(studArray.mediaURL)"
        let latitude : CLLocationDegrees = CLLocationDegrees(exactly: studArray.lat)!
        let longitude : CLLocationDegrees = CLLocationDegrees(exactly: studArray.long)!
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        secondaryMapView.addAnnotation(annotation)
        secondaryMapView.selectAnnotation(annotation, animated: true)
    }
}
