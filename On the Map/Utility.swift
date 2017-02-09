//
//  Utility.swift
//  On the Map
//
//  Created by Octavio Cedeno on 2/8/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import Foundation
import UIKit

//helper functions

class Utility {
    
    var udacityBlue: UIColor = UIColor(hue: 0.5472, saturation: 0.9, brightness: 0.87, alpha: 1.0)
    var udacityGrey: UIColor = UIColor(hue: 0, saturation: 0, brightness: 0.84, alpha: 1.0)
    
    //MARK: Shared Instance
    class func sharedInstance() -> Utility {
        struct Singleton {
            static var sharedInstance = Utility()
        }
        return Singleton.sharedInstance
    }

}

extension UIViewController {
    
    func displayError(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default) {(alert) in
            
            return Void()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendError(message: String){
        print("\(message)")
    }
    
    func navigateToViewController(viewcontroller: String) {
        DispatchQueue.main.async {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: viewcontroller)
            self.present(controller, animated: true, completion: nil)
        }
    }
}
