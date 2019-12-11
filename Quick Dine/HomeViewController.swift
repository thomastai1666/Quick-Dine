//
//  HomeViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/29/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet var restaurauntCollectionView: UICollectionView!
    @IBOutlet weak var restaurauntSearchBar: UISearchBar!
    
    var menuItems = [MenuItem]()
    var filteredRestaurauntList = [Restauraunt]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addRestauraunts()
        restaurauntSearchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRestaurauntList.removeAll()
        for restauraunt in restaurauntList{
            if (restauraunt.name.lowercased().contains(searchBar.text!.lowercased()) ||
                restauraunt.description.lowercased().contains(searchBar.text!.lowercased())){
                filteredRestaurauntList.append(restauraunt)
            }
        }
        restaurauntCollectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        restaurauntSearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
            restaurauntCollectionView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        restaurauntCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isSearching && restaurauntSearchBar.text != ""){
            return filteredRestaurauntList.count
        }
        else{
            return restaurauntList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if(isSearching && restaurauntSearchBar.text != ""){
            cell.restaurauntImage.image = filteredRestaurauntList[indexPath.row].image
            cell.restaurauntName.text = filteredRestaurauntList[indexPath.row].name
            cell.restaurauntDescription.text = filteredRestaurauntList[indexPath.row].description
            cell.restaurauntID = filteredRestaurauntList[indexPath.row].identifier
        }
        else{
            cell.restaurauntImage.image = restaurauntList[indexPath.row].image
            cell.restaurauntName.text = restaurauntList[indexPath.row].name
            cell.restaurauntDescription.text = restaurauntList[indexPath.row].description
            cell.restaurauntID = restaurauntList[indexPath.row].identifier
        }
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.masksToBounds = true
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            cell.restaurauntName.textColor = UIColor.black;
            cell.restaurauntDescription.textColor = UIColor.black;
            cell.contentView.layer.backgroundColor = UIColor.white.cgColor;
        } else {
            // User Interface is Light
            cell.restaurauntName.textColor = UIColor.white;
            cell.restaurauntDescription.textColor = UIColor.white;
            cell.contentView.layer.backgroundColor = UIColor.darkGray.cgColor;
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentMenuViewController(tableID: restaurauntList[indexPath.row].identifier)
    }
    
    func presentMenuViewController(tableID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        restaurauntID = tableID
        controller.isPreviewOnly = true
        self.present(controller, animated: true, completion: nil)
    }

}
