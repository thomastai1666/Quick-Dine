//
//  MoreViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/1/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit
import FirebaseAuth

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
       try! Auth.auth().signOut()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.present(controller, animated: true, completion: nil)
    }
    
}
