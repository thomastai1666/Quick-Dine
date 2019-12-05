//
//  MoreViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/1/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var profileEmail: UILabel!
    @IBOutlet var pastOrdersTableView: UITableView!
    @IBOutlet var logoutButton: UIButton!
    
    var user = Auth.auth().currentUser
    let db = Firestore.firestore()
    var pastOrders = [(String, String, String)]()
    var restauraunts = ["0": "McDonalds"]
    var restaurauntPicture = ["McDonalds": UIImage.init(named: "mcdonaldslogo")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getTableData(){
        if (user != nil) {
            profileEmail.text = user?.email
            let docRef = db.collection("orders")
            let query = docRef.whereField("userID", isEqualTo: user!.uid)
            pastOrders = []
            query.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            if let orderDate = document.data()["orderDate"] as? String{
                                if let orderPrice = document.data()["orderPrice"] as? String{
                                    if let restaurauntID = document.data()["restaurauntID"] as? String{
                                        self.pastOrders.append((orderDate, orderPrice, self.restauraunts[restaurauntID] ?? "Unknown Restauraunt"))
                                    }
                                }
                            }
                        }
                    }
                print(self.pastOrders)
                self.pastOrdersTableView.reloadData()
            }
        }
        else{
            logoutButton.setTitle("Sign In", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTableData()
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
       try! Auth.auth().signOut()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.pastOrders.count == 0){
            return 1
        }
        return self.pastOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.pastOrders.count == 0){
            let emptycell = tableView.dequeueReusableCell(withIdentifier: "noorderscell", for: indexPath)
            return emptycell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderViewCell
        cell.orderDate.text = self.pastOrders[indexPath.row].0
        cell.orderPrice.text = self.pastOrders[indexPath.row].1
        cell.restaurauntName.text = self.pastOrders[indexPath.row].2
        cell.restaurauntImage.image = self.restaurauntPicture[self.pastOrders[indexPath.row].2] ?? UIImage.init(named: "defaultlogo")
        cell.restaurauntImage.layer.cornerRadius = 5
        cell.restaurauntImage.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
