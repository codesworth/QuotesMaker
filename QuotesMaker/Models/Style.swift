//
//  Style.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct Style:Codable {
    
    var cornerRadius:CGFloat = 0
    var maskedCorners:CACornerMask?{
        get{
            return (_maskedCorners != nil) ? CACornerMask(rawValue: _maskedCorners!) : nil
        }
        set{
            _maskedCorners = newValue?.rawValue
        }
    }
    private var _maskedCorners:UInt? = nil
    private var _borderColor:StudioColor = .clear
    var borderColor:UIColor{
        get{
            return _borderColor.color
        }
        set{
            _borderColor = StudioColor(color: newValue)
        }
    }
    var borderWidth:CGFloat = 0
    
    //Shadows
    private var _shadowColor:StudioColor = .clear
    
    var shadowColor:UIColor{
        get{
            return _shadowColor.color
        }
        set{
            _shadowColor = StudioColor(color: newValue)
        }
    }
    var shadowOpacity:Float = 0
    var shadowRadius:CGFloat = 0
    var shadowOffset:CGSize = .zero
    
    
}
