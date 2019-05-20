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
    
    class var header:UIFont{
        return .systemFont(ofSize: 18, weight: .medium)
    }
    class func getfeatured()->[UIFont]{
        var famNames:[String] = []
        let fontFam = UIFont.familyNames
        for _ in 0...5{
            famNames.append(fontFam.randomElement() ?? "")
        }
        let allFonts = famNames.compactMap{
            return UIFont.fontNames(forFamilyName: $0)
        }
        var fontNames:[String] = []
        for item in allFonts{
            fontNames.append(contentsOf: item)
        }
        return fontNames.compactMap{UIFont(name: $0, size: 45)}
    }
//    class func font(_ name:Fonts, size:CGFloat = 16)->UIFont{
//        return UIFont(name: name.rawValue, size: size)!
//    }
    
//    class func getFeaturedFonts()->[Font]{
//        var fonts:[Font] = []
//        for font in featureFonts{
//            let font = Font(name: font.key, font: UIFont(name: font.value, size: 40))
//            fonts.append(font)
//        }
//        return fonts
//    }
//
//    struct Font{
//        let name:String
//        let font:UIFont?
//    }
    
//    class var featureFonts:[String:String]{
//        return ["fontjek" : "Fontjek", "candy" : "CANDY INC.", "snow" : "Snowpersons", "painter" : "Painter PERSONAL USE ONLY","Work_Sans":"Work_Sans","Viga":"Viga"]
//    }
}


