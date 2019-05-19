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
        guard availableFonts.isEmpty else { return availableFonts}
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
    
    
    func filterFonts(search string:String)->[UIFont]{
        if availableFonts.isEmpty{getAvailableFonts()}
        return availableFonts.filter{$0.fontName.contains(string)}
    }
    

}
