//
//  GlobalVars.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/3/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import Foundation
import UIKit

//Used for HomeViewController
var restaurauntList = [Restauraunt]()

func addRestauraunts(){
    restaurauntList.removeAll()
    let restaraunt1tables = ["YULZC", "TXSPL"]
    let restauraunt1 = Restauraunt(identifier: "0", name: "McDonalds", image: UIImage(named: "mcdonalds"), description: "Classic American fast food", tables: restaraunt1tables)
    restaurauntList.append(restauraunt1)
    let restaraunt2tables = ["GFJSK", "MSGLC"]
    let restauraunt2 = Restauraunt(identifier: "1", name: "Chick-fil-a", image: UIImage(named: "chickfila"), description: "Home of the chicken sandwhich", tables: restaraunt2tables)
    restaurauntList.append(restauraunt2)
    let restaraunt3tables = ["AXYLO", "TYLDU"]
    let restauraunt3 = Restauraunt(identifier: "2", name: "Olive Garden", image: UIImage(named: "olivegarden"), description: "Casual Italian food", tables: restaraunt3tables)
    restaurauntList.append(restauraunt3)
}

struct Restauraunt{
    let identifier: String
    let name: String
    let image: UIImage?
    let description: String
    let tables: [String]
    
    init(identifier: String, name: String, image: UIImage?, description: String, tables: [String]){
        self.identifier = identifier
        self.name = name
        self.image = image ?? UIImage(named: "defaultRestauraunt")
        self.description = description
        self.tables = tables
    }
}

//Used in CartViewController
var orderedItems = [Item]()

//Used by Menu ViewController, Order View Controller
class MenuItem{
    var itemType: String?
    var items: [Item]?
    
    init(itemType: String, items: [Item]) {
        self.itemType = itemType
        self.items = items
        
    }
}

var mcdonaldsMenu = [MenuItem]()
var chickfilaMenu = [MenuItem]()
var olivegardenMenu = [MenuItem]()
var menus = ["0": mcdonaldsMenu, "1": chickfilaMenu, "2": olivegardenMenu]

func addMenuItems(){
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
    let item10 = Item(itemid: 10, name: "Hotcakes and Sausage", calories: 780, price: 3.89, image: UIImage(named: "item10"))
    let item11 = Item(itemid: 11, name: "Fruit Yogurt", calories: 210, price: 1.89, image: UIImage(named: "item11"))
    let item12 = Item(itemid: 12, name: "Sausage Burrito", calories: 300, price: 1.69, image: UIImage(named: "item12"))
    mcdonaldsMenu.append(MenuItem.init(itemType: "All Day Breakfast", items: [item0, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12]))
    let item13 = Item(itemid: 13, name: "Chick-fil-A Chicken Sandwhich", calories: 440, price: 5.29, image: UIImage(named: "item13"))
    let item14 = Item(itemid: 14, name: "Deluxe Chicken Sandwhich", calories: 500, price: 6.09, image: UIImage(named: "item14"))
    let item15 = Item(itemid: 15, name: "Spicy Chicken Sandwhich", calories: 450, price: 5.69, image: UIImage(named: "item15"))
    let item16 = Item(itemid: 16, name: "Spicy Deluxe Chicken Sandwhich", calories: 540, price: 6.49, image: UIImage(named: "item16"))
    let item17 = Item(itemid: 17, name: "Grilled Chicken Sandwhich", calories: 330, price: 6.79, image: UIImage(named: "item17"))
    let item18 = Item(itemid: 18, name: "Grilled Chicken Sandwhich", calories: 460, price: 8.79, image: UIImage(named: "item18"))
    let item19 = Item(itemid: 19, name: "Chick-fil-A Nuggets", calories: 260, price: 5.49, image: UIImage(named: "item19"))
    let item20 = Item(itemid: 20, name: "Chick-fil-A Strips", calories: 330, price: 5.79, image: UIImage(named: "item20"))
    let item21 = Item(itemid: 21, name: "Grilled Cool Wrap", calories: 350, price: 8.49, image: UIImage(named: "item21"))
    let item22 = Item(itemid: 22, name: "Grilled Nuggets", calories: 110, price: 6.39, image: UIImage(named: "item22"))
    chickfilaMenu.append(MenuItem.init(itemType: "Entrees", items: [item13, item14, item15, item16, item17, item18, item19, item20, item21, item22]))
    let item23 = Item(itemid: 23, name: "Spaghetti", calories: 360, price: 11.99, image: UIImage(named: "item23"))
    let item24 = Item(itemid: 24, name: "Fettuccine Alfredo", calories: 650, price: 11.99, image: UIImage(named: "item24"))
    let item25 = Item(itemid: 25, name: "Asiago Tortelloni", calories: 600, price: 11.99, image: UIImage(named: "item25"))
    let item26 = Item(itemid: 26, name: "Eggplant Parmigiana", calories: 660, price: 11.99, image: UIImage(named: "item26"))
    let item27 = Item(itemid: 27, name: "Grilled Vegetable & Cheese Sandwich", calories: 630, price: 11.99, image: UIImage(named: "item27"))
    let item28 = Item(itemid: 28, name: "Chicken & Cheese Sandwich", calories: 710, price: 12.99, image: UIImage(named: "item28"))
    let item29 = Item(itemid: 29, name: "Creamy Mushroom Ravioli", calories: 610, price: 12.99, image: UIImage(named: "item29"))
    let item30 = Item(itemid: 30, name: "Cheese Ravioli", calories: 500, price: 12.99, image: UIImage(named: "item30"))
    let item31 = Item(itemid: 31, name: "Five Cheese Ziti al Forno", calories: 640, price: 12.99, image: UIImage(named: "item31"))
    let item32 = Item(itemid: 32, name: "Meatball Pizza Bowl", calories: 1090, price: 12.99, image: UIImage(named: "item32"))
    let item33 = Item(itemid: 33, name: "Chicken Alfredo Pizza Bowl", calories: 950, price: 12.99, image: UIImage(named: "item33"))
    let item34 = Item(itemid: 34, name: "Lasagna Classico", calories: 640, price: 13.99, image: UIImage(named: "item34"))
    let item35 = Item(itemid: 35, name: "Chicken Parmigiana", calories: 660, price: 13.99, image: UIImage(named: "item35"))
    let item36 = Item(itemid: 36, name: "Zoodles Primavera", calories: 460, price: 13.99, image: UIImage(named: "item36"))
    let item37 = Item(itemid: 37, name: "Grilled Chicken Margherita", calories: 380, price: 13.99, image: UIImage(named: "item37"))
    let item38 = Item(itemid: 38, name: "Spaghetti with Meatballs", calories: 680, price: 13.99, image: UIImage(named: "item38"))
    let item39 = Item(itemid: 23, name: "Shrimp Scampi", calories: 480, price: 13.99, image: UIImage(named: "item39"))
    olivegardenMenu.append(MenuItem.init(itemType: "Lunch", items: [item23, item24, item25, item26, item27, item28, item29, item30, item31, item32, item33, item34, item35, item36, item37, item38, item39]))
}

//Used in MenuItem class

struct Item {
    let itemid: Int
    let name: String
    let calories: Int
    let price: Float
    let image: UIImage?
    var quantity: Int
    
    init(itemid: Int, name: String, calories: Int, price: Float, image: UIImage? = nil, quantity: Int? = nil) {
        self.itemid = itemid
        self.name = name
        self.calories = calories
        self.price = price
        if(image != nil){
            self.image = image
        }
        else{
            self.image = UIImage.init(named: "defaultitem")
        }
        if(quantity != nil){
            self.quantity = quantity!
        }
        else{
            self.quantity = 0
        }
    }
}

func restaurauntDoesExist(searchText: String) -> Bool{
    var didFindRestauraunt = false
    for restauraunt in restaurauntList{
        for table in restauraunt.tables{
            if(table == searchText){
                didFindRestauraunt = true
            }
        }
    }
    return didFindRestauraunt
}
