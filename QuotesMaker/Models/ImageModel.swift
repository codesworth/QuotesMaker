//
//  ImageModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct ImageLayerModel:LayerModel {
    
    var priority: LayerFrame.LayerPriority = .image
    
    mutating func layerFrame(_ frame: LayerFrame) {
        self.frame = frame
    }
    
    private var _image:UIImage?
    var image:UIImage?{
        mutating get{
            if !isKnownUniquelyReferenced(&_image){
                _image = _image?.mutableCopy() as? UIImage
            }
            return _image
        }
        
    }
    
    
    var frame:LayerFrame?
    
    init(image:UIImage? = nil) {
        _image = image
    }
    
}


