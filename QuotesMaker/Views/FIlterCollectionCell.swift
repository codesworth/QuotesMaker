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
    private var isLoading = false
    private var loadingIndicator:UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator = UIActivityIndicatorView(frame: frame)
        loadingIndicator.hidesWhenStopped = true
        self.addSubview(self.loadingIndicator!)
        loadingIndicator.stopAnimating()
    }
    
    
    func configureView(name:String,image:UIImage){
        
        titleLabel.text = (name == FilterEngine.NoFilter) ? name : CIFilter.localizedName(forFilterName: name)
        if let filteredImage = FilterEngine.globalInstance.imageFor(name){
            imageView.image = filteredImage
            return
        }
        DispatchQueue.main.async { [unowned self] in
            self.loadingIndicator.startAnimating()
            let filteredImage = FilterEngine.applyFilter(name: name, image: image)
            self.imageView.image = filteredImage
            self.loadingIndicator.stopAnimating()
            FilterEngine.globalInstance.saveFiltered(filteredImage, for:name)
        }
    }
}
