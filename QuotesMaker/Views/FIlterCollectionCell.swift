//
//  FIlterCollectionCell.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 17/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView:UIImageView!

    
    
    func configureView(name:String,image:UIImage){
        titleLabel.text = name
        DispatchQueue.main.async {
            let filteredImage = FilterEngine.applyFilter(name: name, image: image)
            self.imageView.image = filteredImage
        }
    }
}
