//
//  ImageModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct ImageLayerModel:LayerModel {

    enum ContentMode:String,CaseIterable,Codable{
        case fill, fit, contain, center
    }
    
    var layerFrame:LayerFrame?
    
    mutating func layerFrame(_ frame: LayerFrame) {
        self.layerFrame = frame
    }
    
    var imageSrc:String?
    
    var style:Style = Style()
    var mode:ContentMode = .fill
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageSrc = try container.decodeIfPresent(String.self, forKey: .imageSrc) ?? nil
        layerFrame = try container.decodeIfPresent(LayerFrame.self, forKey: .layerFrame) ?? nil
        layerIndex = try container.decodeIfPresent(CGFloat.self, forKey: .layerIndex) ?? 0
        style = try container.decodeIfPresent(Style.self, forKey: .style) ?? Style()
        mode = try container.decodeIfPresent(ContentMode.self, forKey: .mode) ?? .fill
        updateTime = try container.decodeIfPresent(TimeInterval.self, forKey: .updateTime) ?? Date().timeIntervalSinceReferenceDate
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

