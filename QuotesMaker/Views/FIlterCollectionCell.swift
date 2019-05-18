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
    @IBOutlet weak var containerView:UIView!
    private var isSet = false
    private var loadingIndicator:UIActivityIndicatorView!
    lazy var imageView:UIImageView = {
        let imv = UIImageView(frame:.zero)
        imv.contentMode = .scaleAspectFit
        imv.clipsToBounds = true
        return imv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addSubview(imageView)
        loadingIndicator = UIActivityIndicatorView(frame: frame)
        loadingIndicator.hidesWhenStopped = true
        self.addSubview(self.loadingIndicator!)
        loadingIndicator.stopAnimating()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func configureView(name:String,image:UIImage,size:CGSize){
        if !isSet{
            let ratio = size.width/size.height
            let newSize:CGSize = (size.width > size.height) ? [140,140 * ratio] : [140 * ratio,140]
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layout{
                $0.width |=| newSize.width
                $0.height |=| newSize.height
                $0.centerX == containerView.centerXAnchor
                $0.centerY == containerView.centerYAnchor
            }
            isSet = true
        }
        titleLabel.text = (name == FilterEngine.NoFilter) ? name : CIFilter.localizedName(forFilterName: name)
        if let filteredImage = FilterEngine.globalInstance.imageFor(name){
            imageView.image = filteredImage
            return
        }
        self.loadingIndicator.startAnimating()
        let queue = DispatchQueue(label: "Filter", qos: .default, attributes: .concurrent)
        queue.async {
            let filteredImage = FilterEngine.applyFilter(name: name, image: image)
            DispatchQueue.main.async { [unowned self] in
                self.imageView.image = filteredImage
                self.loadingIndicator.stopAnimating()
                FilterEngine.globalInstance.saveFiltered(filteredImage, for:name)
            }
        }
        
    }
}
