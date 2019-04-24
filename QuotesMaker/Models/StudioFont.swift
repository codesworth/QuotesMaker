//
//  StudioFont.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioFont:Codable{
    
    private var fontname:String
    private var fontFamily:String
    private var pointSize: CGFloat
    
    var font:UIFont?{
        get{
            return UIFont(name: fontname, size: pointSize)
        }
        set{
            fontname = newValue?.fontName ?? fontname
            fontFamily = newValue?.familyName ?? fontFamily
            pointSize = newValue?.pointSize ?? pointSize
        }
    }
    
    init(font:UIFont) {
        fontname = font.fontName
        fontFamily = font.familyName
        pointSize = font.pointSize
    }
}
