//
//  BlankImageBackingLayer.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class BlankImageBackingLayer:CALayer{
    
    
    override init() {
        super.init()
        setup()
    }
    
    var model:BlankLayerModel = BlankLayerModel(){
        didSet{
            backgroundColor = model.color.cgColor
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
        backgroundColor = UIColor.blankWhite.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


