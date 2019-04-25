//
//  ImageModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct ImageLayerModel:LayerModel {

    
    
    var layerFrame:LayerFrame?
    
    mutating func layerFrame(_ frame: LayerFrame) {
        self.frame = frame
    }
    
    var imageSrc:URL?
    
    var style:Style = Style()
    var frame:LayerFrame?
    
    init() {
        
    }
    
    var type: ModelType{
        return .image
    }
    
    var updateTime: TimeInterval = Date().timeIntervalSinceReferenceDate
    mutating func update(){
        updateTime = Date().timeIntervalSinceReferenceDate
    }
    
    var layerIndex: CGFloat = 0
    
}


extension ImageLayerModel:Codable{}

