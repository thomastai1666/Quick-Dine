//
//  MenuViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UISearchResultsUpdating{
    
    var tableID:String = ""
    var restaurauntID: String = "0"
    var selectedMenu = [MenuItem]()
    var filteredItems = [MenuItem]()
    let searchController = UISearchController(searchResultsController: nil)
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Menu"
        menuTableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
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
        else{
            return selectedMenu.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFiltering){
            return filteredItems[section].items?.count ?? 0
        }
        return selectedMenu[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! MenuViewCell
        if(isFiltering){
        cell.menuName.text = filteredItems[indexPath.section].items![indexPath.row].name
        cell.menuCalorieCount.text = String(filteredItems[indexPath.section].items![indexPath.row].calories) + " Calories"
        cell.menuPrice.text = "$" + String(filteredItems[indexPath.section].items![indexPath.row].price)
        cell.menuImage.image = filteredItems[indexPath.section].items![indexPath.row].image
        cell.setItem(item: filteredItems[indexPath.section].items![indexPath.row])
        cell.menuImage.layer.cornerRadius = 5.0
        
        }
        else{
        cell.menuName.text = selectedMenu[indexPath.section].items![indexPath.row].name
        cell.menuCalorieCount.text = String(selectedMenu[indexPath.section].items![indexPath.row].calories) + " Calories"
        cell.menuPrice.text = "$" + String(selectedMenu[indexPath.section].items![indexPath.row].price)
        cell.menuImage.image = selectedMenu[indexPath.section].items![indexPath.row].image
        cell.setItem(item: selectedMenu[indexPath.section].items![indexPath.row])
        cell.menuImage.layer.cornerRadius = 5.0
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
