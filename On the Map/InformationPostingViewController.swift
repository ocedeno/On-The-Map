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
    
    var mapVC = MapClient()
    
    //MARK: IBActions
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        guard !(userCurrentLocation.text?.isEmpty)! else {
            print("Current Location Textfield is empty")
            return
        }
        
        if actionButton.titleLabel?.text == "Find on the Map" {
            
            mapViewSettings(location: userCurrentLocation.text!, mapView: mapView)
            
        } else {
            //Do submission action
        }
        
    }
    
    //MARK: Method for Resetting View
    
    func initialViewSettings() {
        
        questionLabel.isHidden = false
        userCurrentLocation.isHidden = false
        userMediaURL.isHidden = true
        actionButton.setTitle("Find on the Map", for: .normal)
        mapView.isHidden = true
    }
    
    func mapViewSettings(location: String, mapView: MKMapView) {
        
        questionLabel.isHidden = true
        userCurrentLocation.isHidden = true
        userMediaURL.isHidden = false
        actionButton.setTitle("Submit", for: .normal)
        mapView.isHidden = false
        mapVC.forwardGeocoding(address: location, mapView: mapView)
        
    }
}
