//
//  TemplateCell.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 29/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class TemplateCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageVIew.clipsToBounds = true
        // Initialization code
    }
    
    func configureView(src:URL,name:String){
        titleLabel.text = name
        do {
            let data = try Data(contentsOf: src)
            let image = UIImage(data: data)
            imageVIew.image = image
        } catch let err {
            print(err.localizedDescription)
        }
        
    }

}
