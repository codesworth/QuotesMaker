//
//  ImageModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct ImageLayerModel:LayerModel {
    
    var layerFrame:LayerFrame?
    
    mutating func layerFrame(_ frame: LayerFrame) {
        self.frame = frame
    }
    
    var image:UIImage?
    var style:Style = Style()
    var frame:LayerFrame?
    
    init(image:UIImage? = nil) {
        self.image = image
    }
    
}


