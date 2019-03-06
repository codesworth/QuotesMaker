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
    
    var model:TextLayerModel!{
        didSet{
            string = model.outPutString()
        }
    }
    
    
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
    
    func setText(_ text:String){
        model.string = text
        string = model.outPutString()
    }
    
    
    func setAttributes(){
//        borderColor = UIColor.green.cgColor
//        borderWidth = 1
        backgroundColor  = UIColor.clear.cgColor
        isWrapped = true
        //alignmentMode = .center
        truncationMode = .none
        //string = model.outPutString()
    }
}
