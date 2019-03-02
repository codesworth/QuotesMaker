//
//  Fonts.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


enum Fonts:String{
    case fontjek = "Fontjek", candy = "CANDY INC.", snow = "Snowpersons", painter = "Painter PERSONAL USE ONLY"
}

extension UIFont{
    
    class func font(_ name:Fonts, size:CGFloat = 16)->UIFont{
        return UIFont(name: name.rawValue, size: size)!
    }
}
