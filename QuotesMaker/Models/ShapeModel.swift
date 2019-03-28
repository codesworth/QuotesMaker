//
//  ShapeModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct ShapeModel{
    var isGradient:Bool = false
    var gradient:GradientLayerModel?
    var solid:BlankLayerModel?
    var style:Style = Style()
    var layerFrame:LayerFrame?
    var updateTime:TimeInterval = Date().timeIntervalSinceNow
    
    mutating func update(){
        updateTime = Date().timeIntervalSinceNow
    }
}

extension ShapeModel:LayerModel{}


extension ShapeModel:Equatable{
    static func == (lhs: ShapeModel, rhs: ShapeModel) -> Bool {
        return lhs.updateTime == rhs.updateTime
    }
}
