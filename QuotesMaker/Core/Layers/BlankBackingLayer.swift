//
//  BlankImageBackingLayer.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class BlankBackingLayer:CALayer{
    
    
    override init() {
        super.init()
        setup()
    }
    
    var previousModels:[BlankLayerModel] = []
    
    var model:BlankLayerModel = BlankLayerModel(){
        didSet{
            backgroundColor = model.color.cgColor
            if previousModels.isEmpty{previousModels.push(model)}else{previousModels.push(oldValue)}
        }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        setup()
    }
    
    func setBackGroundColor(_ color:UIColor){
        backgroundColor = color.cgColor
        
    }
    
    func setup(){
        backgroundColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



