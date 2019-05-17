//
//  FilterEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class FilterEngine:NSObject{
    
    
    private var supportedFilterCategories = [
        kCICategoryColorEffect,
        kCICategoryColorAdjustment,
        kCICategoryHalftoneEffect,
        kCICategoryReduction,
        kCICategorySharpen,
        kCICategoryStylize,
        kCICategoryTileEffect,
        kCICategoryTransition
    ].sorted()
    
    func supportedFilterNamesInCategories(_ category:String) -> [String]{
        return CIFilter.filterNames(inCategory: category)
    }
    
    func allFilters()->[String]{
        return CIFilter.filterNames(inCategories: supportedFilterCategories)
    }
    
    override init() {
        super.init()
    }
    
    func filterFor(_ name:String)->CIFilter?{
        return CIFilter(name: name)
    }
}
