//
//  ViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 12/20/16.
//  Copyright © 2016 Octavio Cedeno. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {


    let mainNavController = "ManagerNavigationController"
    let loginViewController = "LoginViewController"
    let loginButton = FBSDKLoginButton()
    
    //MARK: IBOutlets
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    
    //MARK: Creating FB Button

    override func viewDidLoad() {

        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        let newCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 70)
        loginButton.center = newCenter
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
    }
    
    //MARK: Navigate to View Controller
    func navigateToViewController(viewcontroller: String) {
        DispatchQueue.main.async {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: viewcontroller)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: Facebook Login/Logout Methods
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //segue into a new view
        navigateToViewController(viewcontroller: mainNavController)
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        navigateToViewController(viewcontroller: loginViewController)
        
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
            
            self.navigateToViewController(viewcontroller: self.mainNavController)
            print(userKeyID)
        }
    }
    
    @IBAction func createAccountButton() {
        
        UIApplication.shared.open(URL(string: "https://www.udacity.com/account/auth#!/signup")!)
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> LoginViewController {
        struct Singleton {
            static var sharedInstance = LoginViewController()
        }
        return Singleton.sharedInstance
    }
}
