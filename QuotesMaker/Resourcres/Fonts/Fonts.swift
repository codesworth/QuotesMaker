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
    
    class func getFeaturedFonts()->[Font]{
        var fonts:[Font] = []
        for font in featureFonts{
            let font = Font(name: font.key, font: UIFont(name: font.value, size: 40)!)
            fonts.append(font)
        }
        return fonts
    }
    
    struct Font{
        let name:String
        let font:UIFont
    }
    
    class var featureFonts:[String:String]{
        return ["fontjek" : "Fontjek", "candy" : "CANDY INC.", "snow" : "Snowpersons", "painter" : "Painter PERSONAL USE ONLY"]
    }
}


