//
//  BackingFilterOverLay.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingGradientlayer: CAGradientLayer {
    
    override init(layer: Any) {
        super.init()
        setup()
    }
    
    private var model:GradientLayerModel!{
        didSet{
            startPoint = model.startPoint
            endPoint = model.endPoint
            locations = model.locations
            colors = model.colors
        }
    }
    
    override init() {
        super.init()
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        model = GradientLayerModel.defualt()
    }
}
