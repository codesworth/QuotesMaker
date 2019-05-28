//
//  Filter+Extension.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension CIFilter{
    
    var aliasName:String{
        switch name {
        case "CILinearToSRGBToneCurve":
            return "Steam"
        case "CIMinimumComponent":
            return "1930"
        case "CIMaximumComponent":
            return "1945"
        default:
            guard let alias = CIFilter.localizedName(forFilterName: name) else {return "Unknown"}
            return alias.replacingOccurrences(of: "Photo", with: "").replacingOccurrences(of: "Effect", with: "").replacingOccurrences(of: "Color", with: "")
        }
       
        
    }
    
    class func alias(_ name:String)->String{
        switch name {
        case "CILinearToSRGBToneCurve":
            return "Steam"
        case "CIMinimumComponent":
            return "1930"
        case "CIMaximumComponent":
            return "1945"
        default:
            guard let alias = CIFilter.localizedName(forFilterName: name) else {return "Unknown"}
            return alias.replacingOccurrences(of: "Photo", with: "").replacingOccurrences(of: "Effect", with: "").replacingOccurrences(of: "Color", with: "")
        }
    }
}
