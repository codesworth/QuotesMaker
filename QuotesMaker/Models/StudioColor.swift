//
//  StudioColor.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioColor:Codable{
    
    class var magenta:StudioColor{
       return StudioColor(color: .magenta)
    }
    
    class var cyan:StudioColor{
        return StudioColor(color: .cyan)
    }
    
    class var clear:StudioColor{
        return StudioColor(color: .clear)
    }
    
    class var black:StudioColor{
        return StudioColor(color: .black)
    }
    
    private var _green:CGFloat
    private var _blue:CGFloat
    private var _red:CGFloat
    private var alpha:CGFloat
    
    init(color:UIColor) {
        color.getRed(&_red, green: &_green, blue: &_blue, alpha: &alpha)
    }
    
    var color:UIColor{
        get{
            return UIColor(red: _red, green: _green, blue: _blue, alpha: alpha)
        }
        set{
            newValue.getRed(&_red, green:&_green, blue: &_blue, alpha:&alpha)
        }
    }
    
    var cgColor:CGColor{
        get{
            return color.cgColor
        }
        set{
            UIColor(cgColor: newValue).getRed(&_red, green:&_green, blue: &_blue, alpha:&alpha)
        }
    }
    
}


