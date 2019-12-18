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
    private var engine:FilterEngine!
    lazy var imageView:UIImageView = {
        let imv = UIImageView(frame:.zero)
        imv.contentMode = .scaleAspectFit
        imv.clipsToBounds = true
        engine = FilterEngine()
        return imv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .primaryDark
        containerView.addSubview(imageView)
        loadingIndicator = UIActivityIndicatorView(frame: frame)
        loadingIndicator.hidesWhenStopped = true
        self.addSubview(self.loadingIndicator!)
        loadingIndicator.stopAnimating()
        //backgroundColor = .black
        
        imageView.roundCorners(5)
        //roundCorners(5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func configureView(name:String,image:UIImage,size:CGSize, intrinsicSize:CGSize = [140,140], contentMode:UIView.ContentMode = .scaleAspectFit){
        
        
        if !isSet{
            imageView.contentMode = contentMode
            
            let ratio = size.width/size.height
            let newSize:CGSize = (size.width > size.height) ? [intrinsicSize.width,intrinsicSize.height * (1/ratio)] : [intrinsicSize.width * ratio,intrinsicSize.height]
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layout{
                $0.width |=| newSize.width
                $0.height |=| newSize.height
                $0.centerX == containerView.centerXAnchor
                $0.centerY == containerView.centerYAnchor
            }
            isSet = true
        }
        titleLabel.text = CIFilter.alias(name)//(name == FilterEngine.NoFilter) ? name : CIFilter.localizedName(forFilterName: name) ?? name
        if let filteredImage = FilterEngine.globalInstance.imageFor(name){
            imageView.image = filteredImage
            return
        }
        self.loadingIndicator.startAnimating()
        
        let queue = DispatchQueue(label: "Filter", qos: .default, attributes: .concurrent)
        queue.async {
            
            let filteredImage = self.engine.applyFilter(name: name, image: image)
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = filteredImage
                self?.loadingIndicator.stopAnimating()
                FilterEngine.globalInstance.saveFiltered(filteredImage, for:name)
            }
        }
        
    }
}
