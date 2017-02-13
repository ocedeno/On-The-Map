//
//  InformationPostingViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 2/6/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {
    
    
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
    
    var mapClient = MapClient()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        userCurrentLocation.delegate = self
        userMediaURL.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector (InformationPostingViewController.dismissKeyboard)))
        initialViewSettings()
    }
    
    func dismissKeyboard() {
        userCurrentLocation.resignFirstResponder()
        userMediaURL.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userCurrentLocation.resignFirstResponder()
        userMediaURL.resignFirstResponder()
        return true
    }
    
    func showActivityIndicatory(uiView: UIView) {
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        
        if fullyRendered {
            actInd.stopAnimating()
        }
        
    }
    
    //MARK: IBActions
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        guard !(userCurrentLocation.text?.isEmpty)! else {
            displayError(title: "Error Finding Location", message: "Location field is empty.")
            print("Current Location Textfield is empty")
            return
        }
        
        if actionButton.titleLabel?.text == " Find on the Map " {
            
            showActivityIndicatory(uiView: self.view)
            mapViewSettings(location: userCurrentLocation.text!, mapView: mapView)
            
        }else {
            
            guard (userMediaURL?.text != "") else {
                self.displayError(title: "Error", message: "Please add a Media URL")
                return
            }
            
            submitUserLocation(mediaURL: userMediaURL.text!)
            let alert = UIAlertController(title: "Success", message: "Your points on the map! Go check it out!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (alert) in
                
                LoginViewController.sharedInstance().populateData(completionHandler: { (result, error) in
                    
                    guard error == nil else {
                        
                        self.displayError(title: "Error: Submitting Location.", message: (error?.localizedDescription)!)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.cancelAction()
                        MapViewController.sharedInstance().updateMapLocations()
                        self.mapClient.centralizeLocations(lat: DataModelObject.sharedInstance().currentUserLat, lon: DataModelObject.sharedInstance().currentUserLon, mapView: DataModelObject.sharedInstance().universalMapView)
                    }
                })
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Method for Resetting Views
    
    func initialViewSettings() {
        
        questionLabel.isHidden = false
        userCurrentLocation.isHidden = false
        userMediaURL.isHidden = true
        topImageView.backgroundColor = Utility.sharedInstance().udacityGrey
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
        mapClient.forwardGeocoding(address: location,
                                   mapView: mapView,
                                   viewController: self)
        
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
