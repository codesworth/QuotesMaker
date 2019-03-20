//
//  BlankLayerModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct BlankLayerModel {
    
    var color:UIColor = .lightGray
    var alpha: CGFloat = 1
    
    var layerframe:LayerFrame? = nil
    
}


extension BlankLayerModel:LayerModel{
    
    mutating func layerFrame(_ frame: LayerFrame) {
        layerframe = frame
    }
    
    
    var priority: LayerFrame.LayerPriority{
        return .plainColor
    }
}
