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
}

extension ShapeModel:LayerModel{}
