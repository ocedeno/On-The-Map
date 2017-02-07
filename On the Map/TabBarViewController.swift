//
//  TabBarViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/15/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutPressed() {
        DispatchQueue.main.async {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func placeUserLocation(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddUserLocation", sender: self)
    }
    
    @IBAction func refreshUsersData(_ sender: UIBarButtonItem) {
        print(AppDelegate.sharedInstance().studArray)
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> TabBarViewController {
        struct Singleton {
            static var sharedInstance = TabBarViewController()
        }
        return Singleton.sharedInstance
    }

}
