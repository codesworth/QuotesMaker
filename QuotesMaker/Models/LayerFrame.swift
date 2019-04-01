//
//  LayerFrame.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct LayerFrame {
    
    let xCoordinate:CGFloat
    let yCoordinte:CGFloat
    let width:CGFloat
    let height:CGFloat
    
    
    init(_ axis:CGPoint, sized:CGSize) {
        xCoordinate = axis.x
        yCoordinte = axis.y
        width = sized.width
        height = sized.height
    }
    
}
