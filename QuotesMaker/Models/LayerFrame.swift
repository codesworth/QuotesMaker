//
//  LayerFrame.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct LayerFrame {
    
//    enum LayerPriority:Int{
//        case image = 0
//        case plainColor = 1
//        case gradient = 2
//        case text = 3
//    }
//
    let xCoordinate:CGFloat
    let yCoordinte:CGFloat
    let width:CGFloat
    let height:CGFloat
    
    //let containingBounds:CGRect
    
    init(_ axis:CGPoint, sized:CGSize) {
        xCoordinate = axis.x
        yCoordinte = axis.y
        width = sized.width
        height = sized.height
    }
    
}
