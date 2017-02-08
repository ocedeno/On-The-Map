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
    
    //MARK: Declaring Variables/Constants
    
    let mainNavController = "ManagerNavigationController"
    let loginViewController = "LoginViewController"
    let loginButton = FBSDKLoginButton()
    
    //MARK: IBOutlets
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    
    override func viewDidLoad() {
        
        //MARK: Padding TextFields
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userPassword.frame.height))
        
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
        populateData()
        
    }
    
    func getFBData(){
        
        //MARK: Graph Request for Facebook
        let params = ["fields" : "first_name, last_name"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)!
        graphRequest.start { (connection, result, error) in
            
            guard (error == nil) else {
                print("There was an error retrieving user info from FB. **\(error)**")
                return
            }
            
            let userData = result as! [String: AnyObject]
            let currentUserID = userData["id"]
            DataModelObject.sharedInstance().userInfo = userData
            DataModelObject.sharedInstance().currentUserKeyID = currentUserID as! String?
        }
    }
    
    //Method to populate the student array in App Delegate
    
    func populateData(){
        
        ParseClient.sharedInstance().getStudentLocations(limit: 100) { (result, error) in
            
            DispatchQueue.main.async {
                
                guard (result != nil), (error == nil) else {
                    print("Results were nil. Error:\(error)")
                    return
                }
                
                DataModelObject.sharedInstance().studArray = StudentInformation.convertStudentData(array: result!)
            }
        }
    }
    
    //MARK: Method - Navigate to View Controller
    
    func navigateToViewController(viewcontroller: String) {
        DispatchQueue.main.async {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: viewcontroller)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: Method - Facebook Login/Logout
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        navigateToViewController(viewcontroller: mainNavController)
        getFBData()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        navigateToViewController(viewcontroller: loginViewController)
    }
    
    //MARK: Method - Error Handling
    
    func displayError(title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default) {(alert) in
            return Void()
        })
        print("***DISPLAY ALERT***")
        self.present(alert, animated: true, completion: nil)
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
            
            let accountDictionary = result?["account"]!
            let userKeyID = accountDictionary?["key"] as? String
            DataModelObject.sharedInstance().currentUserKeyID = userKeyID
            UdacityClient.sharedInstance().getUdacityUserData(userKeyID: userKeyID!, completionHandler: { (results, error) in
                
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
    
    //MARK: Shared Instance
    class func sharedInstance() -> LoginViewController {
        struct Singleton {
            static var sharedInstance = LoginViewController()
        }
        return Singleton.sharedInstance
    }
}
