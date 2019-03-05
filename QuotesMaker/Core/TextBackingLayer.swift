//
//  TextBackingLayer.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class TextBackingLayer: CATextLayer {

    override init(layer: Any) {
        super.init(layer: layer)
        setAttributes()
    }
    
    var model = TextLayerModel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        setAttributes()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttributes()
    }
    
    
    
    func setAttributes(){
        isWrapped = true
        alignmentMode = .center
        truncationMode = .none
        string = model.outPutString()
    }
}
