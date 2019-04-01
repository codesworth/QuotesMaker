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
    let yCoordinate:CGFloat
    let width:CGFloat
    let height:CGFloat
    
    
    init(_ axis:CGPoint, sized:CGSize) {
        xCoordinate = axis.x
        yCoordinate = axis.y
        width = sized.width
        height = sized.height
    }
    
    func awakeFrom(bounds:CGRect)->CGRect{
        //let origin:CGPoint = [initialOrigin.x / `super`.bounds.maxX,initialOrigin.y / `super`.bounds.maxY]
       // let sizedRatio = Dimensions.sizedRatio(of: frame.size, in: `super`.frame.size)
        let origin:CGPoint = [xCoordinate * bounds.maxX, yCoordinate * bounds.maxY]
        let size:CGSize = [width * bounds.width, height * bounds.height]
        return CGRect(origin: origin, size: size)
    }
    
    
}


extension LayerFrame:Equatable{
    public static func == (lhs: LayerFrame, rhs: LayerFrame) -> Bool{
        return lhs.xCoordinate == rhs.xCoordinate && lhs.yCoordinate == rhs.yCoordinate && lhs.width == rhs.width && lhs.height == rhs.height
    }
}
