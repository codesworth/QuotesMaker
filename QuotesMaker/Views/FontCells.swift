//
//  FontCells.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class FontCells: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        nameLabel.layer.cornerRadius = 4
        mainLable.layer.cornerRadius = 4
        mainLable.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    
    func configure(font:UIFont.Font){
        mainLable.font = font.font
        nameLabel.text = font.name
    }

}
