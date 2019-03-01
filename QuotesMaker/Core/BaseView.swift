//
//  BaseView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 01/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class BaseView:UIImageView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var currentSublayer:CALayer?{
        
        return layer.sublayers?.last
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.primary.cgColor
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLayer(_ layer:CALayer){
        self.layer.addSublayer(layer)
        //layer.bounds = bounds
        layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
    }
    
    
}
