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
        
        labelview.textColor = .white
        
    }
    
    func configureView(_ process:Processes){
        switch process.subProcess {
        case .home:
            imageView.image = #imageLiteral(resourceName: "home")
            break
        case .addShadpe:
            imageView.image = #imageLiteral(resourceName: "rect")
            break
        case .selectImage:
            imageView.image = #imageLiteral(resourceName: "img_ic")
            break
        case .addText:
            imageView.image = #imageLiteral(resourceName: "txt")
            break
        case .preview:
            imageView.image = #imageLiteral(resourceName: "prev")
            break
        case .save:
            imageView.image = #imageLiteral(resourceName: "save")
            break
        case .startOver:
            imageView.image = #imageLiteral(resourceName: "startover")
            break
        }
        imageView.setImageMaskColor(.white)
        labelview.text = process.name
    }

}
