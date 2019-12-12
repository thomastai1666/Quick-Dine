//
//  RestaurauntViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/11/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SafariServices

class RestaurauntViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var restauraunt: Restauraunt = restaurauntList[0]
    @IBOutlet var restImage: UIImageView!
    @IBOutlet var restMapView: MKMapView!
    @IBOutlet var restName: UILabel!
    @IBOutlet var restAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restImage.image = restauraunt.image
        restName.text = restauraunt.name
        restAddress.text = restauraunt.address
        setUpMapView()
    }
    
    func setUpMapView(){
        restMapView.mapType = MKMapType.standard
        
        let regionRadius: CLLocationDistance = 500
        let location = restauraunt.location
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        restMapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = restauraunt.name
        restMapView.addAnnotation(annotation)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(indexPath.row == 0){
            cell.imageView?.image = UIImage.init(systemName: "book")
            cell.textLabel?.text = "View Menu"
        }
        else if(indexPath.row == 1){
            cell.imageView?.image = UIImage.init(systemName: "phone.fill")
            cell.textLabel?.text = "Call Restauraunt"
        }
        else if(indexPath.row == 2){
            cell.imageView?.image = UIImage.init(systemName: "safari")
            cell.textLabel?.text = "Visit Website"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.row == 0){
            //Show Menu
            presentMenuViewController()
        }
        else if(indexPath.row == 1){
            //Call Restauraunt
            if let url = URL(string: "tel://\(restauraunt.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else if(indexPath.row == 2){
            //Show Website
            let svc = SFSafariViewController(url: URL(string:restauraunt.website)!)
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    func presentMenuViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        restaurauntID = self.restauraunt.identifier
        controller.isPreviewOnly = true
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
