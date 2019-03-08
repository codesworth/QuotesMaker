//
//  BlankLayerModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct BlankLayerModel {
    
    var color:UIColor
    var alpha: CGFloat
    
    var frame:LayerFrame?
}


extension BlankLayerModel:LayerModel{
    
    var priority: LayerFrame.LayerPriority{
        return .plainColor
    }
}
