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
        print(src.path)
        titleLabel.text = name
        let image = UIImage(contentsOfFile: src.path)
        imageVIew.image = image
        let exist = FileManager.default.fileExists(atPath: src.path)
        print(exist)
//        do {
//            print(src.path)
//            let data = try Data(contentsOf: src)
//            let image = UIImage(data: data)
//            imageVIew.image = image
//        } catch let err {
//            print(err.localizedDescription)
//        }
        
    }

}
