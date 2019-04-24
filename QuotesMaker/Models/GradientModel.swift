//
//  GradientModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct GradientLayerModel{
    
    
    
    static var originalColor = UIColor.lightGray.cgColor
    static var reservedLocations = [0, 0.25,0.50,0.75]
    
    var layerFrame:LayerFrame?
    var alphas:[CGFloat] = [1,1]
    var _locations:[CGFloat] = [0,0.75]
    var startPoint:CGPoint = 0
    var endPoint:CGPoint = 1
    
    private var _internalcolors:[StudioColor] = [StudioColor.cyan, StudioColor.magenta]

    func getColorAt(_ index:Int)->UIColor{
        guard index < _internalcolors.endIndex else {return  _internalcolors.last!.color.withAlphaComponent(alphas.last!)}
        return  _internalcolors[index].color.withAlphaComponent(alphas[index])
    }
    
    func gradientColors()->[CGColor]{
        var colors:[CGColor] = []
        for (index, color) in _internalcolors.enumerated(){
            let alpheredColor =  color.color.withAlphaComponent(alphas[index]).cgColor
            colors.append(alpheredColor)
        }
        return colors
    }
    
    func getRawColorAt(_ index:Int)->UIColor{
        guard index < _internalcolors.endIndex else {return  _internalcolors.last!.color}
        return _internalcolors[index].color
    }
    
    mutating func setColor(_ color:UIColor, at index:Int){
        if index < _internalcolors.endIndex{
            _internalcolors[index].color = color
        }else{
            _internalcolors.append(StudioColor(color: color))
        }
        
    }
    
    var locations:[NSNumber]{
        get{
            return _locations.compactMap{NSNumber(value: Float($0))}
        }
        set{
            _locations = newValue.compactMap{CGFloat($0.floatValue)}
        }
    }
    
    mutating func removeLast(){
        _internalcolors.removeLast()
        alphas.removeLast()
        locations.removeLast()
    }
    
    
    
    
    
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




extension GradientLayerModel:Codable{}


extension GradientLayerModel:Equatable{
    static func == (lhs: GradientLayerModel, rhs: GradientLayerModel) -> Bool {
        return /*lhs.colors == rhs.colors &&*/ lhs.locations == rhs.locations && lhs.endPoint == rhs.endPoint && lhs.startPoint == rhs.startPoint
    }
}
    
    

