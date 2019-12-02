//
//  MenuViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class MenuItem{
    var itemType: String?
    var itemNames: [String]?
    
    init(itemType: String, itemNames: [String]) {
        self.itemType = itemType
        self.itemNames = itemNames
    }
}

class MenuViewController: UIViewController{
    
    var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuItems.append(MenuItem.init(itemType: "Breakfast", itemNames: ["Egg McMuffin", "Sausage McMuffin", "Sausage McMuffin with Egg", "Bacon, Egg & Cheese Biscuit", "Sausage Biscuit", "Sausage Biscuit with Egg", "Bacon, Egg & Cheese McGridles", "Sausage, Egg & Cheese McGriddles", "Sausage McGriddles", "Hotcakes", "Hotcakes and Sausage", "Fruit Yogurt Parfait", "Sausage Burrito", "Hash Browns"]))
        
        menuItems.append(MenuItem.init(itemType: "Beverages", itemNames: ["Coca-Cola", "Sprite", "Fanta Orange", "Dr Pepper", "Mix by Sprite Tropic Berry", "Diet Coke", "Chocolate Shake", "Vanilla Shake", "Strawberry Shake", "Hot Chocolate", "Iced Tea", "Sweet Tea", "Chocolate Milk Jug", "Low Fat Milk Jug", "Water"]))
        
        menuItems.append(MenuItem.init(itemType: "Burgers", itemNames: ["Bacon BBQ Burger", "Double Bacon BBQ Burger", "Big Mac", "Quarter Pounder with Cheese", "Double Quarter Pounder with Cheese", "Quarter Pounder with Cheese Deluxe", "Quarter Pounder with Cheese Bacon", "Double Cheeeseburger", "McDouble", "Cheeseburger", "Hamburger"]))
        
        menuItems.append(MenuItem.init(itemType: "Chicken & Sandwhiches", itemNames: ["4 Piece Chicken McNuggets", "Buttermilk Crispy Tenders", "Grilled Chicken Sandwich", "Crispy Chicken Sandwich", "McChicken", "Filet-O-Fish"]))
        
        menuItems.append(MenuItem.init(itemType: "Combo Meal", itemNames: ["Bacon, Egg & Cheese McGriddles Meal", "Sausage Egg & Cheese McGriddles Meal", "Artisan Grilled Chicken Sandwich Meal", "Egg McMuffin Meal", "Sausage McGriddles Meal", "Sausage Burrito Meal", "Buttermilk Crispy Chicken Sandwhich Meal", "Big Mac Meal", "Filet-O-Fish Meal", "Sausage McMuffin Meal", "Double Quarter Pounder with Cheese Meal", "10 Piece Chicken McNuggets Meal", "Bacon, Egg & Cheese Biscuit Meal", "Quarter Pounder with Cheese Meal", "Sausage Biscuit with Egg Meal", "Cheeseburger Meal"]))
        
        menuItems.append(MenuItem.init(itemType: "Desserts & Shakes", itemNames: ["Snickerdoodle McFlurry", "Chocolate Shakes", "Vanilla Shake", "Strawberry Shake", "Vanilla Cone", "Hot Fudge Sundae", "McFlurry with M&M's", "Kiddie Cone", "Hot Caramel Sundae", "Strawberry Sundae", "McFlurry with Oreo Cookies", "Baked Apple Pie"]))
        
        menuItems.append(MenuItem.init(itemType: "Happy Meal", itemNames: ["4 Piece Chicken McNuggets Happy Meal", "6 Piece Chicken McNuggets Happy Meal", "Hamburger Happy Meal"]))
        
        menuItems.append(MenuItem.init(itemType: "McCafe Drinks", itemNames: ["Cinnamon Cookie Latte", "Iced Cinnnamon Cookie Latte", "Caramel Macchiato", "Iced Caramel Macchiato", "Cappuccino", "Caramel Cappuccino", "French Vanilla Cappuccino", "Mocha", "Iced Mocha", "Caramel Mocha", "Iced Caramel Mocha", "Latte", "Iced Latte", "Caramel Latte", "Iced Caramel Latte", "French Vanilla Latte", "Iced French Vanilla Latte", "Americano", "Preium Roast Coffee", "Iced Coffee", "Iced Caramel Coffee", "Iced French Vanilla Coffee", "Caramel Frappe", "Mocha Frappe", "Hot Chocoalte", "Strawberry Bannana Smoothie", "Mango Pineapple Soothie"]))
        
        menuItems.append(MenuItem.init(itemType: "McCafe Bakery", itemNames: ["6 piece Donut Sticks", "Baked Apple Pie", "Chocolate Chip Cookie"]))
        
        menuItems.append(MenuItem.init(itemType: "Salads", itemNames: ["Bacon Ranch Salad with Buttermilk Crispy Chicken", "Bacon Ranch Grilled Chicken Salad", "Southwest Buttermilk Crispy Chicken Salad", "Southwest Grilled Chicken Salad"]))
        
        menuItems.append(MenuItem.init(itemType: "Snacks & Sides", itemNames: ["6 piece Donut Sticks", "Small World Famous Fries", "Apple Slices", "Yoplait Low Fat Strawberry Yogurt", "Fruit N Yogurt Parfait", "Side Salad", "Minute Maid Blue Raspberry Slushie", "Minute Maid Fruit Punch Slushie", "Minute Maid Peach Slushie"]))
    }
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].itemNames?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.section].itemNames?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuItems[section].itemType
    }
}
