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
    var gradient:GradientLayerModel?{didSet{update()}}
    var solid:BlankLayerModel?{didSet{update()}}
    var style:Style = Style(){didSet{update()}}
    var layerFrame:LayerFrame?{didSet{update()}}
    var updateTime:TimeInterval = Date().timeIntervalSinceReferenceDate
    var layerIndex: CGFloat = 0
    mutating func update(){
        updateTime = Date().timeIntervalSinceReferenceDate
    }
    
    var type: ModelType{
        return .shape
    }
    
    static func  `default`()->ShapeModel{
        var shape = ShapeModel()
        shape.solid = BlankLayerModel()
        return shape
    }
    
}

extension ShapeModel:LayerModel{}


extension ShapeModel:Equatable{
    static func == (lhs: ShapeModel, rhs: ShapeModel) -> Bool {
        return lhs.updateTime == rhs.updateTime
    }
}
