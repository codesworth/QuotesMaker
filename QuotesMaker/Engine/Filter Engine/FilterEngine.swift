//
//  FilterEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class FilterEngine:NSObject{
    
    var inputImage:UIImage?
    private var supportedFilterCategories = [
        kCICategoryColorEffect,
        kCICategoryColorAdjustment,
        /*kCICategoryHalftoneEffect,
        kCICategoryReduction,
        kCICategorySharpen,
        kCICategoryStylize,
        kCICategoryTileEffect,
        kCICategoryTransition*/
    ].sorted()
    
    func supportedFilterNamesInCategories(_ category:String) -> [String]{
        return CIFilter.filterNames(inCategory: category)
    }
    
    func allFilters()->[String]{
        return CIFilter.filterNames(inCategories: supportedFilterCategories)
    }
    
    var stabilizedFilters:[String] = []
    
    override init() {
        super.init()
        stabilizedFilters = CIFilter.filterNames(inCategory: kCICategoryColorEffect)
    }
    
    func filterFor(_ name:String)->CIFilter?{
        return CIFilter(name: name)
    }
    
    class func applyFilter(name:String,image:UIImage)->UIImage?{
        guard let filter = CIFilter(name: name), let ciimage = CIImage(image: image) else {return nil}
        
        filter.setValue(ciimage, forKey: kCIInputImageKey)
        guard let output = filter.outputImage else {return nil}
        return UIImage(ciImage: output)
    }
}



