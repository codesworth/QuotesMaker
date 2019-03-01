//
//  Dimensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class Dimensions{
    
    class func sizedRectForScale(rectSize:CGSize, scale:CGFloat)->CGSize{
        return [rectSize.width * scale, rectSize.height * scale ]
    }
    
    class func scaledDownFrom(rect:CGSize)->CGSize{
        let lowestSide = min(rect.width, rect.height)
        let maxSide = CGFloat.fixedWidth
        let scaler = maxSide / lowestSide
        return rect.scaledBy(scaler)
        
    }
    
}
