//
//  ViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/20/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    
    //MARK: Variables
    
    var userInfoDictionary = [
        "username" : "",
        "password" : ""
    ]
   
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
        
        //Guard: Text Fields are not Empty
        guard !(userEmailAddress.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        guard !(userPassword.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        //Pass along text field  values to Dictionary
        UdacityClient.MethodParameters.UdacityDictionary["username"] = userEmailAddress.text
        UdacityClient.MethodParameters.UdacityDictionary["password"] = userPassword.text
        
        //Call Method to Authorize User
        UdacityClient.sharedInstance().taskForUdacityAuthentication(UdacityClient.MethodType.Post, parameters: UdacityClient.MethodParameters.UdacityDictionary, jsonBody: UdacityClient.RequestValues.JSONBody) { (response, error) in

        }
    
    }
    
    @IBAction func createAccountButton() {
        
    }
}
