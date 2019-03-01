//
//  QMImageBackingLayer.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class ImageBackingLayer:CALayer{
    
    override init() {
        super.init()
        
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
    }
    
    var orientation:UIImage.Orientation?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImage(_ image:UIImage){
        self.contents = image.cgImage
        orientation = image.imageOrientation
        bounds.size = image.size
    }
    
    
}
