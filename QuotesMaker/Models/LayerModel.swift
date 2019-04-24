//
//  LayerModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

protocol LayerModel:Codable {

    var layerFrame:LayerFrame? {get set}
    var layerIndex:CGFloat {get set}
    var type:ModelType {get}
    var updateTime:TimeInterval {get set}
    
}


enum ModelType:Int {
    case shape = 1
    case text = 2
    case image = 3
}

