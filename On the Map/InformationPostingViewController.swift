//
//  InformationPostingViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 2/6/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController {

    
    //MARK: IBOutlets

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userCurrentLocation: UITextField!
    
    //MARK: IBActions
    
    @IBAction func searchForUserLocation() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
