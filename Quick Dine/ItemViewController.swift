//
//  ItemViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/9/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController{
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCalories: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemQuantity: UILabel!

    var MenuViewCellItem: Item!
    var itemcount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemQuantity.text = String(itemcount)
        print("ItemViewController loaded")
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func minusbuttonPressed(_ sender: Any) {
        if(itemcount > 0){
        itemcount -= 1
        itemQuantity.text = String(itemcount)
        MenuViewCellItem.quantity = itemcount
        }
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        itemcount += 1
        itemQuantity.text = String(itemcount)
        MenuViewCellItem.quantity = itemcount
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if(itemcount > 0 && MenuViewCellItem != nil){
            updateOrAddItem(item: MenuViewCellItem)
        }
        dismiss(animated: true, completion: nil)
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
    
    
}
