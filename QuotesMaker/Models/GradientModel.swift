//
//  GradientModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct GradientLayerModel {
    static var originalColor = UIColor.lightGray.cgColor
    static var reservedLocations = [0, 0.25,0.50,0.75]
    
    
    var colors:[CGColor] = [UIColor.cyan, UIColor.magenta].map{$0.cgColor}
    var locations:[NSNumber] = [0,0.75]
    let startPoint:CGPoint = 0
    let endPoint:CGPoint = 1
    
    static func defualt()->GradientLayerModel{
        return GradientLayerModel()
    }
    
    mutating func addLocation(at index:Int){
        switch index{
        case 3:
            locations.append(0.25)
            break
        case 4:
            locations.append(0.50)
            break
        default:
            break
        }
    }
    
}
