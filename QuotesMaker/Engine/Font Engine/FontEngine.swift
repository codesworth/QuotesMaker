//
//  FontEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 19/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class FontEngine: NSObject {
    
    var fontsize:CGFloat = 40
    private var availableFonts:[UIFont]
    
    override init() {
        availableFonts = []
        super.init()
        
    }
    
    @discardableResult
    func getAvailableFonts()->[UIFont]{
        var fontNames:[String] = []
        let familyNames = UIFont.familyNames
        let allFonts = familyNames.compactMap{
            return UIFont.fontNames(forFamilyName: $0)
        }
        for item in allFonts{
            fontNames.append(contentsOf: item)
        }
        availableFonts = fontNames.compactMap{UIFont(name: $0, size: fontsize)}
        return availableFonts
    }
    
    

}
