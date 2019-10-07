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
    var stabilizedHalftoneFilters = CIFilter.filterNames(inCategory: kCICategoryHalftoneEffect)
    var stabilizedReductionFilters = CIFilter.filterNames(inCategory: kCICategoryReduction)
    var stabilizedStylizeFilters = CIFilter.filterNames(inCategory: kCICategoryStylize)
    var stabilizedTransitionFilters = CIFilter.filterNames(inCategory: kCICategoryTransition)
    var stabilizedTilesFilters = CIFilter.filterNames(inCategory: kCICategoryTileEffect)
    override init() {
        super.init()
        let systemFiltered = Filters.availableFilters.filter{CIFilter.localizedName(forFilterName: $0) != nil}
        availableFilters.append(contentsOf:systemFiltered)
        listAllFilters()
    }
    
    func listAllFilters(){
        print("The filters for color effects are: \(availableFilters)")
    }
    
    func filterFor(_ name:String)->CIFilter?{
        return CIFilter(name: name)
    }
    
    class func applyFilter(name:String,image:UIImage)->UIImage?{
        if name == NoFilter{ return image }
        
        let metalGPU = MTLCreateSystemDefaultDevice()!
        let eagl = EAGLContext(api: .openGLES3)
        let context = CIContext.init(eaglContext: eagl!)
        
        guard let filter = CIFilter(name: name), let ciimage = CIImage(image: image) else {return nil}
        
        filter.setValue(ciimage, forKey: kCIInputImageKey)
        guard let output = filter.outputImage else {return nil}
        let cgimage = context.createCGImage(output, from: output.extent)
        return cgimage != nil ? UIImage(cgImage: cgimage!) : nil
    }
    
    class func applyCustomFilters(name:Filters.CustomFilters,image:UIImage)->UIImage?{
        
        guard let ciimage = image.ciImage ?? CIImage(image: image) else {return nil}
        switch name {
        case .Retro:
            let filtered = Filters.apply1977Filter(ciImage: ciimage)
            return (filtered != nil ) ? UIImage(ciImage: filtered!) : nil
        case .Voilet:
            let filtered = Filters.clarendonFilter(foregroundImage: ciimage)
            return (filtered != nil ) ? UIImage(ciImage: filtered!) : nil
        case .Sunny:
            let filtered = Filters.nashvilleFilter(foregroundImage: ciimage)
            return (filtered != nil ) ? UIImage(ciImage: filtered!) : nil
        case .Warm:
            let filtered = Filters.toasterFilter(ciImage: ciimage)
            return (filtered != nil ) ? UIImage(ciImage: filtered!) : nil
        case .Monoscene:
            let filtered = Filters.hazeRemovalFilter(image: ciimage)
            return (filtered != nil ) ? UIImage(ciImage: filtered!) : nil
        }
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

extension Array where Element:Hashable{
    
    mutating func merge1(_ elements:Element...){
        guard !isEmpty else { self = elements; return}
        elements.makeIterator().forEach{if !contains($0){append($0)}}
    }
}



extension Array where Element:Hashable{
    
    mutating func merging(_ elements:Element...){
        guard !isEmpty else {self = elements; return}
        elements.forEach{if !contains($0){append($0)}}
    }
    
    func merge(_ elements:[Element])->[Element]{
        guard !isEmpty else {return elements}
        var array = self
        elements.forEach{if !contains($0){array.append($0)}}
        return array
    }
}





















