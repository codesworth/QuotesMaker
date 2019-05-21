//
//  FilterEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class FilterEngine:NSObject{
    
    static let NoFilter = "No Filter"
    private var _internalContainer:[String:UIImage] = [:]
    
    private static let _global = FilterEngine()
    
    static var globalInstance:FilterEngine{
        return _global
    }
    
    func saveFiltered(_ image:UIImage?, for name:String){
        guard let image = image else {return}
        _internalContainer.updateValue(image, forKey: name)
    }
    
    func imageFor(_ name:String)->UIImage?{
        return _internalContainer[name]
    }
    
    func purge(){
        _internalContainer.removeAll()
        _internalContainer = [:]
    }
    
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
    
    var availableFilters:[String] = [NoFilter]
    
    func allFilters()->[String]{
        return CIFilter.filterNames(inCategories: supportedFilterCategories)
    }
    
    var stabilizedColorFilters:[String] = CIFilter.filterNames(inCategory: kCICategoryColorEffect)
    var stabilizedColorAdjustMentFilters:[String] = CIFilter.filterNames(inCategory: kCICategoryColorAdjustment)
    var stabilizedSharpenFilters:[String] = CIFilter.filterNames(inCategory: kCICategorySharpen)
    
    override init() {
        super.init()
        
        availableFilters.append(contentsOf: stabilizedColorAdjustMentFilters)
        
    }
    
    func filterFor(_ name:String)->CIFilter?{
        return CIFilter(name: name)
    }
    
    class func applyFilter(name:String,image:UIImage)->UIImage?{
        if name == NoFilter{ return image }
        guard let filter = CIFilter(name: name), let ciimage = CIImage(image: image) else {return nil}
        
        filter.setValue(ciimage, forKey: kCIInputImageKey)
        if (filter.name == "CIColorCubesMixedWithMask"){
            filter.setValue(ciimage, forKey: kCIInputMaskImageKey)
        }
        guard let output = filter.outputImage else {return nil}
        return UIImage(ciImage: output)
    }
}

//class NoFilter:CIFilter{
//
//    static let Category = "0xNoFilter"
//
//    override var attributes: [String : Any]{
//        return [
//            kCIAttributeFilterDisplayName: "No Filter" as Any,
//
//            "inputImage": [kCIAttributeIdentity: 0,
//                           kCIAttributeClass: "CIImage",
//                           kCIAttributeDisplayName: "Image",
//                           kCIAttributeType: kCIAttributeTypeImage]
//        ]
//    }
//
//    override init() {
//        super.init()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override var outputImage: CIImage?{
//        guard let image = attributes[kCIInputImageKey] as? CIImage else {fatalError("Input Image Not Set")}
//        return image
//    }
//}
//
//class NoFilterConstructor:NSObject, CIFilterConstructor{
//
//    func filter(withName name: String) -> CIFilter? {
//        if name == "\(NoFilter.Category)"{
//            return NoFilter()
//        }
//        return nil
//    }
//}


