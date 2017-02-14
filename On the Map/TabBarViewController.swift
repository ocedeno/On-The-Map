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
        
        LoginViewController.sharedInstance().populateData { (result, error) in
            
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
    
    //MARK: Shared Instance
    class func sharedInstance() -> TabBarViewController {
        struct Singleton {
            static var sharedInstance = TabBarViewController()
        }
        return Singleton.sharedInstance
    }
    
}
