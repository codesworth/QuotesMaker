
//
//  WrapperView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class WrapperView: UIView {
    
    var superlayer:CALayer!
    var isGradient = false
    
    init(frame: CGRect, layer:CALayer) {
        super.init(frame: frame)
        superlayer = layer
        if type(of: superlayer) == BackingGradientlayer.self{isGradient = true}
        initialize()
    }
    var model:LayerModel!{
        didSet{
            if isGradient{
                if let mod = model as? GradientLayerModel{
                    (superlayer as! BackingGradientlayer).model = mod
                }
            }else{
                if let mod = model as? BlankLayerModel{
                    (superlayer as! BlankImageBackingLayer).model = mod
                }
            }
        }
    }
    
    var id:String{
        if type(of: superlayer) == BackingGradientlayer.self{
            return "View \(id_tag):Gradient"
        }else{
            return "View\(id_tag)"
        }
    }
    var id_tag: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize(){
        layer.addSublayer(superlayer)
        superlayer.bounds = layer.bounds
        superlayer.position = [bounds.midX,bounds.midY]
        movedInFocus()
    }
}
