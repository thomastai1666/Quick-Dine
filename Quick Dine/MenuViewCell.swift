//
//  MenuViewCell.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {
    
    @IBOutlet var menuImage: UIImageView!
    @IBOutlet var menuName: UILabel!
    @IBOutlet var menuCalorieCount: UILabel!
    @IBOutlet var menuPrice: UILabel!
    @IBOutlet var menuItemCount: UILabel!
    
    var MenuViewCellItem: Item!
    
    var itemcount = 0
    
    override func layoutSubviews() {
        menuItemCount.text = String(itemcount)
    }
    
    func setItem(item: Item){
        self.MenuViewCellItem = item
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        if(itemcount > 0){
            itemcount -= 1
            menuItemCount.text = String(itemcount)
            MenuViewCellItem.quantity = itemcount
            updateOrAddItem(item: MenuViewCellItem)
        }
        if(itemcount == 0){
            removeItem(item: MenuViewCellItem)
        }
        print(orderedItems)
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        itemcount += 1
        menuItemCount.text = String(itemcount)
        MenuViewCellItem.quantity = itemcount
        updateOrAddItem(item: MenuViewCellItem)
        print(orderedItems)
    }
    
    func updateOrAddItem(item: Item){
        for(index, listitem) in orderedItems.enumerated(){
            if(item.itemid == listitem.itemid){
                orderedItems[index] = item
                return
            }
        }
        //Not found in array
        orderedItems.append(item)
    }
    
    func removeItem(item: Item){
        for(index, listitem) in orderedItems.enumerated(){
            if(item.itemid == listitem.itemid){
                orderedItems.remove(at: index)
                return
            }
        }
    }
}
