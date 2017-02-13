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

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    //MARK: Declare Variables/Constants
    
    let mainNavController = "ManagerNavigationController"
    let loginViewController = "LoginViewController"
    let loginButton = FBSDKLoginButton()
    
    //MARK: IBOutlets
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    
    override func viewDidLoad() {
        
        userEmailAddress.delegate = self
        userPassword.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(LoginViewController.dismissKeyboard)))
        
        //MARK: Padding TextFields
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.userPassword.frame.height))
        
        userEmailAddress.leftView = paddingView
        userPassword.leftView = paddingView
        userEmailAddress.leftViewMode = UITextFieldViewMode.whileEditing
        userPassword.leftViewMode = UITextFieldViewMode.whileEditing
        
        //MARK: Creating FB Button
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        let newCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 70)
        loginButton.center = newCenter
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
        //MARK: Populating Data Model Object
        populateData { (result, error) in
            
        }
    }
    
    func getFBData(){
        
        //MARK: Graph Request for Facebook
        let params = ["fields" : "first_name, last_name"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)!
        graphRequest.start { (connection, result, error) in
            
            guard (error == nil) else {
                self.displayError(title: "Login Issue", message: "There was an error retrieving your information from Facebook.")
                self.sendError(message: "***Retrieving Userinfo unsuccessful. Error: \(error)***")
                return
            }
            
            let userData = result as! [String: AnyObject]
            let currentUserID = userData["id"]
            DataModelObject.sharedInstance().userInfo = userData
            DataModelObject.sharedInstance().currentUserKeyID = currentUserID as! String?
        }
    }
    
    //Method to populate the student array in App Delegate
    
    func populateData(completionHandler: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void){
        
        ParseClient.sharedInstance().getStudentLocations(limit: 100) { (result, error) in
            
            DispatchQueue.main.async {
                
                guard (result != nil), (error == nil) else {
                    self.displayError(title: "Retrieving Data", message: "Could not retrieve student locations from Parse. Try again later.")
                    self.sendError(message: "Populating student data returned nil. Error:\(error)")
                    return
                }
                
                DataModelObject.sharedInstance().studArray = StudentInformation.convertStudentData(array: result!)
                completionHandler(nil, nil)
                
            }
        }
    }
    
    //MARK: Method - Facebook Login/Logout
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        guard error == nil else {
            displayError(title: "Error: Facebook Login", message: "There was an issue logging you through Facebook. Please try again later.")
            sendError(message: error.localizedDescription)
            return
        }
        
        navigateToViewController(viewcontroller: mainNavController)
        getFBData()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        navigateToViewController(viewcontroller: loginViewController)
    }
    
    //MARK: IBActions
    
    //Login Button Method
    @IBAction func loginButtonPressed() {
        
        //MARK: Guard Text Fields are not Empty
        
        guard !(userEmailAddress.text?.isEmpty)!, !(userPassword.text?.isEmpty)! else {
            displayError(title: "Error", message: "The Password / Email Address field is empty.")
            return
        }
        
        //MARK: Run Udacity Authentication
        
        UdacityClient.sharedInstance().udacityAuthenticationRequest(username: userEmailAddress.text!, password: userPassword.text!) { (result, error) in
            
            guard (result != nil), (error == nil) else {
                self.sendError(message: "There was an error authroizing Udacity. Error: \(error)")
                self.displayError(title: "Udacity Login Issue", message: (error?.localizedDescription)!)
                
                return
            }
            
            let accountDictionary = result?["account"]!
            let userKeyID = accountDictionary?["key"] as? String
            DataModelObject.sharedInstance().currentUserKeyID = userKeyID
            UdacityClient.sharedInstance().getUdacityUserData(userKeyID: userKeyID!, completionHandler: { (results, error) in
                
                guard (results != nil), (error == nil) else {
                    DispatchQueue.main.async {
                        self.sendError(message: "There was an error authroizing Udacity. Error: \(error)")
                        self.displayError(title: "Udacity Login Issue", message: (error?.localizedDescription)!)
                    }
                    return
                }
                
                let userData = results?["user"] as! [String : AnyObject]
                DataModelObject.sharedInstance().userInfo = userData
                
            })
            
            self.navigateToViewController(viewcontroller: self.mainNavController)
        }
    }
    
    //Create Account Method
    @IBAction func createAccountButton() {
        
        UIApplication.shared.open(URL(string: "https://www.udacity.com/account/auth#!/signup")!)
    }
    
    func dismissKeyboard(){
        userPassword.resignFirstResponder()
        userEmailAddress.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userPassword.resignFirstResponder()
        userEmailAddress.resignFirstResponder()
        return true
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> LoginViewController {
        struct Singleton {
            static var sharedInstance = LoginViewController()
        }
        return Singleton.sharedInstance
    }
}
