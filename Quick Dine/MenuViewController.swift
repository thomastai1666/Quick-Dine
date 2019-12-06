//
//  MenuViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/2/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //do something here
    }
    
    
    var tableID:String = ""
    var restaurauntID: String = "0"
    var selectedMenu = [MenuItem]()
    @IBOutlet weak var menuSearchBar: UISearchBar!
    var filteredItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Data Source: mcdonalds.com
        addMenuItems()
        findTable()
    }
    
    func findTable(){
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
        selectedMenu = menus[restaurauntID] ?? mcdonaldsMenu
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedMenu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMenu[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! MenuViewCell
        cell.menuName.text = selectedMenu[indexPath.section].items![indexPath.row].name
        cell.menuCalorieCount.text = String(selectedMenu[indexPath.section].items![indexPath.row].calories) + " Calories"
        cell.menuPrice.text = "$" + String(selectedMenu[indexPath.section].items![indexPath.row].price)
        cell.menuImage.image = selectedMenu[indexPath.section].items![indexPath.row].image
        cell.setItem(item: selectedMenu[indexPath.section].items![indexPath.row])
        cell.menuImage.layer.cornerRadius = 5.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selectedMenu[section].itemType
    }
    
    
}
