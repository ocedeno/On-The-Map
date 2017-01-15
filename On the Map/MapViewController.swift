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

    @IBOutlet weak var mapView: MKMapView!
    
    let mapClient = MapClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapClient.updateCurrentLocation(mapView: mapView
        )
    }

}
