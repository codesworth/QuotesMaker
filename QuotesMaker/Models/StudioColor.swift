//
//  StudioColor.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

struct StudioColor:Codable{
    
    static var magenta:StudioColor{
       return StudioColor(color: .magenta)
    }
    
    static var lightGray:StudioColor{
        return StudioColor(color: .lightGray)
    }
    
    static var cyan:StudioColor{
        return StudioColor(color: .cyan)
    }
    
    static var clear:StudioColor{
        return StudioColor(color: .clear)
    }
    
    static var black:StudioColor{
        return StudioColor(color: .black)
    }
    
    private var _green:CGFloat = 0
    private var _blue:CGFloat = 0
    private var _red:CGFloat = 0
    private var alpha:CGFloat = 0
    
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


