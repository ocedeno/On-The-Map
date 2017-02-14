//
//  TabBarViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/15/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class TabBarViewController: UITabBarController {
    
    var udacClient = UdacityClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func logoutPressed() {
        
        udacClient.udacityLogoutRequest { (result, error) in
            
            guard (error == nil) else {
                print("There was an error logging user out of Udacity. **\(error)**")
                return
            }
        }
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func placeUserLocation(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "AddUserLocation", sender: self)
    }
    
    @IBAction func refreshUsersData(_ sender: UIBarButtonItem) {
        
        populateData { (result, error) in
            
            guard error == nil else{
                self.displayError(title: "Error Refreshing Data", message: (error?.localizedDescription)!)
                return
            }
            
            DispatchQueue.main.async {
                let mapVC = self.viewControllers?[0] as? MapViewController
                mapVC?.updateMapLocations()
                let tbVC = self.viewControllers?[1] as? LocationListViewController
                tbVC?.refreshTableView()
            }
        }
        
    }
    
    func populateData(completionHandler: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void){
        
        ParseClient.sharedInstance().getStudentLocations(limit: 100) { (result, error) in
            
            DispatchQueue.main.async {
                
                guard (result != nil) || (error == nil) else {
                    completionHandler(nil, NSError(domain: "On the Map", code: 0, userInfo:  [NSLocalizedDescriptionKey:"It appears you are not connected to the internet."]))
                    self.displayError(title: "Retrieving Data", message: "Could not retrieve student locations from Parse. Try again later.")
                    self.sendError(message: "Populating student data returned nil. Error:\(error)")
                    return
                }
                
                DataModelObject.sharedInstance().studArray = StudentInformation.convertStudentData(array: result!)
                completionHandler(nil, nil)
                
            }
        }
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> TabBarViewController {
        struct Singleton {
            static var sharedInstance = TabBarViewController()
        }
        return Singleton.sharedInstance
    }
    
}
