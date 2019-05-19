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
        if #available(iOS 11.0, *) {
            nameLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        nameLabel.layer.cornerRadius = 4
        mainLable.layer.cornerRadius = 4
        if #available(iOS 11.0, *) {
            mainLable.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func configure(font:UIFont.Font){
        mainLable.font = font.font
        nameLabel.text = font.name.capitalized
    }
    
    func configure(font:UIFont){
        mainLable.font = font
        nameLabel.text = font.fontName
    }

}
