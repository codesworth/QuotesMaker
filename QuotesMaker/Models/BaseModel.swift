//
//  BaseModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

struct BaseModel:Codable {
    
    public private (set) var modelType:Int
    public private (set) var text:TextLayerModel?
    public private (set) var image:ImageLayerModel?
    var shape:ShapeModel?
    var layerFrame:LayerFrame{
        get{
           let type = ModelType(rawValue: modelType)!
            switch type {
            case .image:
                return image!.layerFrame!
            case .text:
                return text!.layerFrame!
            case .shape:
                return shape!.layerFrame!
            }
        }
    }
    var layerIndex:CGFloat {
        get{
            let type = ModelType(rawValue: modelType)!
            switch type {
            case .image:
                return image!.layerIndex
            case .text:
                return text!.layerIndex
            case .shape:
                return shape!.layerIndex
            }
        }
    }
    init(type:ModelType, model:LayerModel) {
        modelType = type.rawValue
        switch type {
        case .image:
            image = model as? ImageLayerModel
            break
        case .text:
            text = model as? TextLayerModel
            break
        case .shape:
            shape = model as? ShapeModel
        }
    }
}


extension BaseModel:Equatable{
    static func == (lhs: BaseModel, rhs: BaseModel) -> Bool {
        return lhs.layerIndex == rhs.layerIndex
    }
    
    
    
}
