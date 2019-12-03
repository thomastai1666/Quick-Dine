//
//  MenuViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
    
    var menuItems = [MenuItem]()
    var tableID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Data Source: mcdonalds.com
        let item0 = Item(itemid: 0, name: "Egg McMuffin", calories: 300, price: 3.99, image: UIImage(named: "item0"))
        let item1 = Item(itemid: 1, name: "Sausage McMuffin", calories: 400, price: 1.69, image: UIImage(named: "item1"))
        let item2 = Item(itemid: 2, name: "Sausage McMuffin with Egg", calories: 480, price: 3.49, image: UIImage(named: "item2"))
        let item3 = Item(itemid: 3, name: "Bacon, Egg & Cheese Biscuit", calories: 450, price: 3.99, image: UIImage(named: "item3"))
        let item4 = Item(itemid: 4, name: "Sausage Biscuit", calories: 460, price: 1.59, image: UIImage(named: "item4"))
        let item5 = Item(itemid: 5, name: "Sausage Biscuit with Egg", calories: 530, price: 3.79, image: UIImage(named: "item5"))
        let item6 = Item(itemid: 6, name: "Bacon, Egg & Cheese McGriddles", calories: 420, price: 3.99, image: UIImage(named: "item6"))
        let item7 = Item(itemid: 7, name: "Sausage, Egg & Cheese McGriddles", calories: 550, price: 3.99, image: UIImage(named: "item7"))
        let item8 = Item(itemid: 8, name: "Sausage McGriddles", calories: 430, price: 2.89, image: UIImage(named: "item8"))
        let item9 = Item(itemid: 9, name: "Hotcakes", calories: 590, price: 2.79, image: UIImage(named: "item9"))
        let item10 = Item(itemid: 10, name: "Hotcakes and Sausage", calories: 780, price: 780, image: UIImage(named: "item10"))
        let item11 = Item(itemid: 11, name: "Fruit Yogurt", calories: 210, price: 1.89, image: UIImage(named: "item11"))
        let item12 = Item(itemid: 12, name: "Sausage Burrito", calories: 300, price: 1.69, image: UIImage(named: "item12"))
        menuItems.append(MenuItem.init(itemType: "All Day Breakfast", items: [item0, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12]))
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! MenuViewCell
        cell.menuName.text = menuItems[indexPath.section].items![indexPath.row].name
        cell.menuCalorieCount.text = String(menuItems[indexPath.section].items![indexPath.row].calories) + " Calories"
        cell.menuPrice.text = "$" + String(menuItems[indexPath.section].items![indexPath.row].price)
        cell.menuImage.image = menuItems[indexPath.section].items![indexPath.row].image
        cell.setItem(item: menuItems[indexPath.section].items![indexPath.row])
        cell.menuImage.layer.cornerRadius = 5.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuItems[section].itemType
    }
    
    
}
