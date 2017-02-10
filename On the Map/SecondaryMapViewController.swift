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
    var lat : Double!
    var lon : Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did Segue")
        mapClient.centralizeLocations(lat: lat, lon: lon, mapView: secondaryMapView)
        
    }
}
