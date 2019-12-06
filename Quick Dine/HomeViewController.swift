//
//  HomeViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/29/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var restaurauntCollectionView: UICollectionView!
    
    var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addRestauraunts()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        restaurauntCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurauntList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.restaurauntImage.image = restaurauntList[indexPath.row].image
        cell.restaurauntName.text = restaurauntList[indexPath.row].name
        cell.restaurauntDescription.text = restaurauntList[indexPath.row].description
        cell.restaurauntID = restaurauntList[indexPath.row].identifier
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
        controller.restaurauntID = tableID
        self.present(controller, animated: true, completion: nil)
    }

}
