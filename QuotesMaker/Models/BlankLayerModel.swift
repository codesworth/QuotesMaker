//
//  BlankLayerModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct BlankLayerModel {
    
    private var _internalColor:UIColor = .lightGray
    var color:UIColor{
        return _internalColor.withAlphaComponent(alpha)
    }
    var rawColor:UIColor{
        return _internalColor
    }
    var alpha: CGFloat = 1
    //var finalTouch:UITouch? = nil
    mutating func updateCcolor(_ color:UIColor){
        _internalColor = color
    }
}

extension BlankLayerModel:Equatable{
    
    static func == (lhs: BlankLayerModel, rhs: BlankLayerModel) -> Bool {
        return lhs.color == rhs.color
    }
}

