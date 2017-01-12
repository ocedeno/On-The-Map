//
//  ViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/20/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    
    //MARK: IBOutlets
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    
    //MARK: Creating FB Button

    override func viewDidLoad() {
        let loginButton = FBSDKLoginButton()
        let bottomLayoutCenter = CGPoint(x: 187, y: 600)
        loginButton.center = bottomLayoutCenter
        
        view.addSubview(loginButton)
        
//        guard let accessToken = FBSDKAccessToken.current() else {
//            print("No Access Token")
//            return
//        }
    }
   
    //MARK: Error Handling
    
    func displayError(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default) {(alert) in
            return Void()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: IBActions
    
    @IBAction func loginButtonPressed() {
        
        //MARK: Guard Text Fields are not Empty
        guard !(userEmailAddress.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        guard !(userPassword.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        //MARK: Run Udacity Authentication
        UdacityClient.sharedInstance().udacityAuthenticationRequest(username: userEmailAddress.text!, password: userPassword.text!) { (result, error) in
            
            guard let userAccountInfo = result?["account"] as! [String:AnyObject]? else {
                self.displayError(title: "Login Error", message: "There was an error in logging in. Please try again later.")
                return
            }
            
            guard let userKeyID = userAccountInfo["key"] as? String else {
                self.displayError(title: "Login Error", message: "There was an error in logging in. Please try again later.")
                return
            }
            
            UdacityClient.sharedInstance().getUdacityUserData(userKeyID: userKeyID, completionHandler: { (result, error) in
                
                ParseClient.sharedInstance().getStudentLocations(limit: 100, completionHandler: { (result, error) in
                    print(result!)
                })
            })
        }
    }
    
    @IBAction func createAccountButton() {
        
    }
}
