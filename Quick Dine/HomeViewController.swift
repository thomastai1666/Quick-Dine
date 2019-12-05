//
//  HomeViewController.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/29/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let restaurauntName = ["Panera Bread", "McDonalds", "DigInn"]
    let restaurauntImages = [UIImage(named: "panerabread"), UIImage(named: "mcdonalds"), UIImage(named: "diginn")]
    let restaurauntDescription = ["Salads, sandwhiches and soups", "Fast food burgers and fries", "Local American food"]
    @IBOutlet var restaurauntCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        restaurauntCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurauntName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.restaurauntImage.image = restaurauntImages[indexPath.row]
        cell.restaurauntName.text = restaurauntName[indexPath.row]
        cell.restaurauntDescription.text = restaurauntDescription[indexPath.row]
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
        presentMenuViewController(tableID: "Implement Later")
    }
    
    func presentMenuViewController(tableID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "menuVC")
        self.present(controller, animated: true, completion: nil)
    }

}
