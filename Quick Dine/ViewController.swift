//
//  ViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/21/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

extension UIViewController {
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.view.endEditing(true)
  }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

