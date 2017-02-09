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
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        initialViewSettings()
    }
    
    var mapClient = MapClient()
    
    //MARK: IBActions
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        guard !(userCurrentLocation.text?.isEmpty)! else {
            displayError(title: "Error Finding Location", message: "Location field is empty.")
            print("Current Location Textfield is empty")
            return
        }
        
        if actionButton.titleLabel?.text == " Find on the Map " {
            
            mapViewSettings(location: userCurrentLocation.text!, mapView: mapView)
            
        } else {
            //Do submission action
            submitUserLocation(mediaURL: userMediaURL.text!)
            cancelAction()
        }
        
    }
    
    //MARK: Method for Resetting Views
    
    func initialViewSettings() {
        
        questionLabel.isHidden = false
        userCurrentLocation.isHidden = false
        userMediaURL.isHidden = true
        actionButton.setTitle(" Find on the Map ", for: .normal)
        mapView.isHidden = true
        userCurrentLocation.attributedPlaceholder = NSAttributedString(string: "Enter Your Current Location",
                                                                       attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func mapViewSettings(location: String, mapView: MKMapView) {
        
        questionLabel.isHidden = true
        userCurrentLocation.isHidden = true
        userMediaURL.isHidden = false
        topImageView.backgroundColor = Utility.sharedInstance().udacityBlue
        actionButton.setTitle(" Submit ", for: .normal)
        mapView.isHidden = false
        mapClient.forwardGeocoding(address: location, mapView: mapView)
    }
    
    //MARK: Method for Submitting User Location
    
    func submitUserLocation(mediaURL: String) {
        
        let userDictionary = DataModelObject.sharedInstance().userInfo
        let studentStructDictionary : [String: AnyObject] = [
            "firstName" : userDictionary["first_name"]! as AnyObject,
            "lastName" : userDictionary["last_name"]! as AnyObject,
            "mediaURL" : mediaURL as AnyObject,
            "latitude" : DataModelObject.sharedInstance().currentUserLat as AnyObject,
            "longitude" : DataModelObject.sharedInstance().currentUserLon as AnyObject
        ]
        
        let studStruc : StudentInformation = StudentInformation(userDict: studentStructDictionary)
        ParseClient.sharedInstance().postStudentLocation(userKeyID: DataModelObject.sharedInstance().currentUserKeyID!, mapString: userCurrentLocation.text!, studentInformation: studStruc) { (results, error) in
            
        }
    }
    
    //MARK: Resign Current View Controller
    
    @IBAction func cancelAction() {
        
        dismiss(animated: true, completion: nil)
        
    }
}
