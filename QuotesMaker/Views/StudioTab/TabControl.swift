//
//  TabControl.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

@IBDesignable
class TabControl: UIControl {
    
    var contentImageView:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleAspectFill
        return img
    }()

    @IBInspectable private var image:UIImage?{
        didSet{
            contentImageView.image = image
        }
    }
    
    @IBInspectable var background: UIColor = .white{
        didSet{
            backgroundColor = background
        }
    }
    
    @IBInspectable private var title:BasicLabel = {
        let lab = BasicLabel(frame: .zero)
        return lab
    }()
    
    init(frame: CGRect,image:UIImage) {
        super.init(frame: frame)
        self.image = image
        initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    
    func initialize(){
        addSubview(contentImageView)
        contentImageView.image = self.image
    }
    
    func addtarget(_ target:Any, selector:Selector){
        addTarget(target, action: selector, for: .touchUpInside)
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentImageView.clipsToBounds = true
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //We find out which sides is the smallest so we can set a sqaure with min side
        let minDimension = min(bounds.size.width, bounds.size.height)
        guard minDimension > 0 else { return}
        NSLayoutConstraint.activate([
            contentImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentImageView.widthAnchor.constraint(equalToConstant: minDimension - 10),
            contentImageView.heightAnchor.constraint(equalToConstant: minDimension - 10)
        ])
    }
}
