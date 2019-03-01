//
//  Dimensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import LiteralExtensions

class Dimensions{
    
    func sizedRectForScale(rectSize:CGSize, scale:CGFloat)->CGSize{
        return [rectSize.width * scale, rectSize.height * scale ]
    }
    
}
