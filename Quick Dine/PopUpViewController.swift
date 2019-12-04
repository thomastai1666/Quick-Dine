//
//  PopUpViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/4/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController{
    
    @IBOutlet var PopUpView: UIView!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var BackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopUpView.layer.cornerRadius = 10
        PopUpView.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 5
    }
    
    @IBAction func dismissPopup(_ sender: Any) {
        BackgroundView?.backgroundColor = UIColor(white: 1, alpha: 0)
        dismiss(animated: true, completion: nil)
    }
    
    
}
