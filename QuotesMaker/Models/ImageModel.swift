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
    
    var image:UIImage?{
        get{
            return (_data != nil) ?  UIImage(data: _data!) : nil
        }
        set{
            _data = newValue?.pngData()
        }
    }
    private var _data:Data?
    
    var style:Style = Style()
    var frame:LayerFrame?
    
    init(image:UIImage? = nil) {
        self.image = image
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

