//
//  MenuViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

var restaurauntID: String = "0"

class MenuViewController: UIViewController, UISearchResultsUpdating{
    
    var tableID:String = ""
    var selectedMenu = [MenuItem]()
    var filteredItems = [MenuItem]()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var menuTableView: UITableView!
    
    func updateSearchResults(for searchController: UISearchController) {
        filterUsingSearchText(searchText: searchController.searchBar.text!)
    }

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addMenuItems()
        selectedMenu = findTable()
        menuTableView.reloadData()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        menuStackView.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        menuTableView.reloadData()
    }
    
    func filterUsingSearchText(searchText: String) {
        var matchedItems = [Item]()
        filteredItems.removeAll()
        for itemcategory in selectedMenu{
            for item in itemcategory.items!{
                if(item.name.lowercased().contains(searchText.lowercased())){
                    matchedItems.append(item)
                }
            }
        }
        filteredItems.append(MenuItem.init(itemType: "Search Results", items: matchedItems))
        menuTableView.reloadData()
    }
    
    func findTable() -> [MenuItem]{
        print(tableID)
        if(tableID != ""){
            for restauraunt in restaurauntList{
                for table in restauraunt.tables{
                    if(table == tableID){
                        restaurauntID = restauraunt.identifier
                    }
                }
            }
        }
        return menus[restaurauntID] ?? mcdonaldsMenu
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(isFiltering){
            return filteredItems.count
        }
        print(selectedMenu.count)
        return selectedMenu.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "itemVC") as! ItemViewController
        let cell = tableView.cellForRow(at: indexPath) as! MenuViewCell
        self.present(controller, animated: true, completion: nil)
        controller.itemImage?.image = cell.menuImage.image
        controller.itemName?.text = cell.menuName.text
        controller.itemCalories?.text = cell.menuCalorieCount.text
        controller.itemPrice?.text = cell.menuPrice.text
        controller.itemcount = cell.itemcount
        controller.itemQuantity?.text = cell.menuItemCount.text
        controller.MenuViewCellItem = cell.MenuViewCellItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFiltering){
            return filteredItems[section].items?.count ?? 0
        }
        print(selectedMenu[section].items?.count ?? 0)
        return selectedMenu[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! MenuViewCell
        let useThisMenu:[MenuItem]
        if(isFiltering){
            useThisMenu = filteredItems
        }
        else{
            useThisMenu = selectedMenu
        }
        cell.menuName.text = useThisMenu[indexPath.section].items![indexPath.row].name
        cell.menuCalorieCount.text = String(useThisMenu[indexPath.section].items![indexPath.row].calories) + " Calories"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let itemcost = numberFormatter.string(from: NSNumber(value: useThisMenu[indexPath.section].items![indexPath.row].price))
        cell.menuPrice.text = itemcost
        cell.menuImage.image = useThisMenu[indexPath.section].items![indexPath.row].image
        let menuItemForCell = useThisMenu[indexPath.section].items![indexPath.row]
        cell.setItem(item: menuItemForCell)
        cell.menuImage.layer.cornerRadius = 5.0
        for listitem in orderedItems{
            if(menuItemForCell.itemid == listitem.itemid){
                cell.itemcount = listitem.quantity
                cell.menuItemCount.text = String(listitem.quantity)
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(isFiltering){
            return filteredItems[section].itemType
        }
        else{
            return selectedMenu[section].itemType
        }
    }
    
    
}
