//
//  StudioTabCells.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioTabCells: UICollectionViewCell {

    @IBOutlet weak var control: TabControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        control.isUserInteractionEnabled = false
        isUserInteractionEnabled = true
        backgroundColor = .clear
    }
    
    func configureCell(_ image:UIImage, _ mask:Bool = true){
        control.contentImageView.image = image
        if mask{
            control.contentImageView.setImageMaskColor(.white)
        }
    }


}
