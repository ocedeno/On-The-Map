//
//  LocationListViewController.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/15/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

import UIKit

class LocationListViewController: UITableViewController {
    
    //MARK: variables/constants
    
    let studentArray = DataModelObject.sharedInstance().studArray
    let mapClient = MapClient()
    var mapVC = MapViewController()
    let controller = SecondaryMapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let controller = parent as! TabBarViewController
//        mapVC = controller.viewControllers?[0] as! MapViewController
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh (_ sender: AnyObject) {

        refreshTableView()
    }
    
    func refreshTableView(){
        
        LoginViewController.sharedInstance().populateData { (result, error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                print("Finisehd refreshing")
            }
        }

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataModelObject.sharedInstance().studArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ("\(studentArray[indexPath.row].firstName) \(studentArray[indexPath.row].lastName)")
        
        return cell
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SecondaryMapViewSegue" {
            let indexPath = sender as? IndexPath
            let userLat = studentArray[indexPath!.row].lat
            let userLon = studentArray[indexPath!.row].long
            let controller = segue.destination as? SecondaryMapViewController
            controller?.lon = userLon
            controller?.lat = userLat
            print("Prepare for Segue")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "SecondaryMapViewSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let mediaURL = DataModelObject.sharedInstance().studArray[indexPath.row].mediaURL
        guard (mediaURL != "") else{
            print("\(mediaURL)")
            displayError(title: "Media URL", message: "Sorry, the user did not provide a Media URL.")
            return
        }
        
        UIApplication.shared.open(URL(string: mediaURL)!)
    }
}
