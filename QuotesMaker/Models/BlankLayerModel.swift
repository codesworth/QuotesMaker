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
    
    var layerFrame:LayerFrame? = nil
    
}

extension BlankLayerModel:Equatable{
    
    static func == (lhs: BlankLayerModel, rhs: BlankLayerModel) -> Bool {
        return lhs.color == rhs.color
    }
}


extension BlankLayerModel:LayerModel{}
