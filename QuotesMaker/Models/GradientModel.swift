//
//  GradientModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct GradientLayerModel {
    
    var colors:[CGColor] = [UIColor.cyan, UIColor.magenta].map{$0.cgColor}
    var locations:[NSNumber] = [0,0.7]
    let startPoint:CGPoint = 0
    let endPoint:CGPoint = 1
    
    static func defualt()->GradientLayerModel{
        return GradientLayerModel()
    }
    
    
}
