//
//  PanelCell.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PanelCell: UICollectionViewCell {

    @IBOutlet weak var labelview: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureView(_ process:Processes){
        labelview.text = process.name
    }

}
