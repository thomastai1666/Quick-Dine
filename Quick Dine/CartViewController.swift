//
//  CartViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/3/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import Foundation
import UIKit

class CartViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Cart Loaded")
    }
    
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartViewCell
        print(orderedItems)
        cell.menuName.text = orderedItems[indexPath.row].name
        cell.menuCalorieCount.text = String(orderedItems[indexPath.row].calories) + " Calories"
        cell.menuPrice.text = "$" + String(orderedItems[indexPath.row].price)
        cell.menuImage.image = orderedItems[indexPath.row].image
        cell.itemcount = orderedItems[indexPath.row].quantity
        cell.MenuViewCellItem = orderedItems[indexPath.row]
        cell.menuImage.layer.cornerRadius = 5.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

