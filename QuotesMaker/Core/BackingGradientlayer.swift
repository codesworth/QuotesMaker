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
    
    override init() {
        super.init()
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        startPoint = 0
        endPoint = 1
        locations = [0, 0.7]
        colors = [UIColor.cyan, UIColor.magenta].map{$0.cgColor}
    }
}
