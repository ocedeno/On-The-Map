//
//  ViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/20/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    var appDelagate = AppDelegate()
    
    func displayError(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default) {(alert) in
            return Void()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed() {
        
        guard !(userEmailAddress.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        guard !(userPassword.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        let url = URL(string: "https://www.udacity.com/api/session")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(userEmailAddress.text!)\", \"password\": \"\(userPassword.text!)\"}}".data(using: String.Encoding.utf8)
        
        let task = appDelagate.sharedSession.dataTask(with: request as URLRequest) { (data, response, error) in
            guard (error == nil) else {
                print("An error was discovered.\(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else{
                print("An unsuccessful response was given.\(response)")
                return
            }
            
            guard let data = data else {
                print("There was an error parsing the data.")
                return
            }
            
            
        }
        
        task.resume()
    }
    
    @IBAction func createAccountButton() {
        
    }
}
