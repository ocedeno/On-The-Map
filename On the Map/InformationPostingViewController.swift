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

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userCurrentLocation: UITextField!
    @IBOutlet weak var userMediaURL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        initialViewSettings()
    }
    
    //MARK: IBActions
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        guard (userCurrentLocation.text != nil) else {
            print("Current Location Textfield is empty")
            return
        }
        
        mapViewSettings(location: userCurrentLocation.text!)
        
    }
    
    //MARK: Method for Resetting View
    
    func initialViewSettings() {
        
        mapView.isHidden = true
        bottomImageView.alpha = 1
        userMediaURL.isHidden = true
    }
    
    func mapViewSettings(location: String) {
        
        questionLabel.isHidden = true
        mapView.isHidden = false
        userCurrentLocation.isHidden = true
        bottomImageView.alpha = 0.25
        userMediaURL.isHidden = false
    }
}
