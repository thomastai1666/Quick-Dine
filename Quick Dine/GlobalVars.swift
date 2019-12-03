//
//  GlobalVars.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/3/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import Foundation
import UIKit

var orderedItems = [Item]()

class MenuItem{
    var itemType: String?
    var items: [Item]?
    
    init(itemType: String, items: [Item]) {
        self.itemType = itemType
        self.items = items
    }
}

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
