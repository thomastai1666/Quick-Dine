//
//  CollectionViewCell.swift
//  Quick Dine
//
//  Created by Thomas Tai on 12/1/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var restaurauntImage: UIImageView!
    @IBOutlet weak var restaurauntName: UILabel!
    @IBOutlet weak var restaurauntDescription: UILabel!
    var restaurauntID: String = ""
}
