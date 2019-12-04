//
//  MenuViewCell.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

protocol CartTableDelegate: class {
    func reloadTable()
}

class CartViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuCalorieCount: UILabel!
    @IBOutlet weak var menuPrice: UILabel!
    @IBOutlet weak var menuItemCount: UILabel!
    
    var MenuViewCellItem: Item!
    
    weak var delegate: CartTableDelegate?
    
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
        delegate?.reloadTable()
        print(orderedItems)
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        itemcount += 1
        menuItemCount.text = String(itemcount)
        MenuViewCellItem.quantity = itemcount
        updateOrAddItem(item: MenuViewCellItem)
        delegate?.reloadTable()
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
