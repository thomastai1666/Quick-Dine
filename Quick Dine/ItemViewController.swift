//
//  ItemViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/9/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate:class {
    func dismissed()
}

class ItemViewController: UIViewController, UITextViewDelegate{
    
    var delegate:ModalViewControllerDelegate?

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCalories: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemQuantity: UILabel!
    @IBOutlet var specialRequests: UITextView!
    @IBOutlet var minusButtonOutlet: UIButton!
    @IBOutlet var plusButtonOutlet: UIButton!
    @IBOutlet var addToCartButtonOutlet: UIButton!
    @IBOutlet var speicalRequestsText: UILabel!
    
    var itemImageValue: UIImage?
    var itemNameValue: String?
    var itemCaloriesValue: String?
    var itemPriceValue: String?

    var MenuViewCellItem: Item!
    var itemcount = 0
    var isPreviewOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemQuantity.text = String(itemcount)
        itemName.text = itemNameValue
        itemCalories.text = itemCaloriesValue
        itemPrice.text = itemPriceValue
        itemImage.image = itemImageValue
        specialRequests.delegate = self
        if(isPreviewOnly){
            itemQuantity.isHidden = true
            minusButtonOutlet.isHidden = true
            plusButtonOutlet.isHidden = true
            addToCartButtonOutlet.isHidden = true
            specialRequests.isHidden = true
            speicalRequestsText.isHidden = true
        }
        print("ItemViewController loaded")
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        delegate?.dismissed()
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
            delegate?.dismissed()
            dismiss(animated: true, completion: nil)
        }
        else{
            showAlert(title: "Error", alertMessage: "Item quantity must be greater than 0")
        }
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Enter any requests to the kitchen here"){
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter any requests to the kitchen here"
        }
    }
}
