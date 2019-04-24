//
//  GradientModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct GradientLayerModel{
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_internalcolors.compactMap{UIColor(cgColor: $0)}, forKey: CodingKeys.internalcolors)
        
    }
    
    enum CodingKeys:String,CodingKey {
        case internalcolors
        case ic
    }
    
    static var originalColor = UIColor.lightGray.cgColor
    static var reservedLocations = [0, 0.25,0.50,0.75]
    var layerFrame:LayerFrame?
    var alphas:[CGFloat] = [1,1]
    private var _internalcolors:[CGColor] = [UIColor.cyan, UIColor.magenta].map{$0.cgColor}

    func getColorAt(_ index:Int)->UIColor{
        guard index < _internalcolors.endIndex else {return UIColor(cgColor: _internalcolors.last!).withAlphaComponent(alphas.last!)}
        return UIColor(cgColor: _internalcolors[index]).withAlphaComponent(alphas[index])
    }
    
    func gradientColors()->[CGColor]{
        var colors:[CGColor] = []
        for (index, color) in _internalcolors.enumerated(){
            let alpheredColor = UIColor(cgColor: color).withAlphaComponent(alphas[index]).cgColor
            colors.append(alpheredColor)
        }
        return colors
    }
    
    func getRawColorAt(_ index:Int)->UIColor{
        guard index < _internalcolors.endIndex else {return UIColor(cgColor: _internalcolors.last!)}
        return UIColor(cgColor: _internalcolors[index])
    }
    
    mutating func setColor(_ color:UIColor, at index:Int){
        if index < _internalcolors.endIndex{
            _internalcolors[index] = color.cgColor
        }else{
            _internalcolors.append(color.cgColor)
        }
        
    }
    
    mutating func removeLast(){
        _internalcolors.removeLast()
        alphas.removeLast()
        locations.removeLast()
    }
    
    
    
    var locations:[NSNumber] = [0,0.75]
    var startPoint:CGPoint = 0
    var endPoint:CGPoint = 1
    
    static func defualt()->GradientLayerModel{
        return GradientLayerModel()
    }
    
    mutating func addLocation(at index:Int){
        switch index{
        case 3:
            locations.append(0.25)
            break
        case 4:
            locations.append(0.50)
            break
        default:
            break
        }
    }
    
}

extension UIColor:Encodable{
    public func encode(to encoder: Encoder) throws {
        
    }
}


extension GradientLayerModel:Codable{

    
    init(from decoder: Decoder) throws {
        <#code#>
    }
}


extension GradientLayerModel:Equatable{
    static func == (lhs: GradientLayerModel, rhs: GradientLayerModel) -> Bool {
        return /*lhs.colors == rhs.colors &&*/ lhs.locations == rhs.locations && lhs.endPoint == rhs.endPoint && lhs.startPoint == rhs.startPoint
    }
}
    
    

