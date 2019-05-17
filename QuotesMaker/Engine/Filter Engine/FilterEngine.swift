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
        //NoFilter.Category,
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
        //CIFilter.registerName("0NoFilter", constructor: NoFilterConstructor(), classAttributes: [kCIAttributeFilterCategories:NoFilter.Category])
        stabilizedFilters = CIFilter.filterNames(inCategory: kCICategoryColorEffect)
    }
    
    func filterFor(_ name:String)->CIFilter?{
        return CIFilter(name: name)
    }
    
    class func applyFilter(name:String,image:UIImage)->UIImage?{
        guard let filter = CIFilter(name: name), let ciimage = CIImage(image: image) else {return nil}
        
        filter.setValue(ciimage, forKey: kCIInputImageKey)
        if (filter.name == "CIColorCubesMixedWithMask"){
            filter.setValue(ciimage, forKey: kCIInputMaskImageKey)
        }
        guard let output = filter.outputImage else {return nil}
        return UIImage(ciImage: output)
    }
}

class NoFilter:CIFilter{
    
    static let Category = "0NoFilter"
    
    override var attributes: [String : Any]{
        return [
            kCIAttributeFilterDisplayName: "No Filter" as Any,
            
            "inputImage": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "CIImage",
                           kCIAttributeDisplayName: "Image",
                           kCIAttributeType: kCIAttributeTypeImage]
        ]
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var outputImage: CIImage?{
        guard let image = attributes[kCIInputImageKey] as? CIImage else {fatalError("Input Image Not Set")}
        return image
    }
}

class NoFilterConstructor:NSObject, CIFilterConstructor{
    
    func filter(withName name: String) -> CIFilter? {
        if name == "\(NoFilter.self)"{
            return NoFilter()
        }
        return nil
    }
}


