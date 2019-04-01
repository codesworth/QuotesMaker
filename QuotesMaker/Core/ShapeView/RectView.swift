//
//  RectView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol ShapableView {
    var model:ShapeModel{get set}
    func updateModel(_ model:ShapeModel)
    func layerChanged(_ isGradient:Bool)
}

class RectView:SuperRectView{
    
    var superlayer:CALayer!
    var previousModels = ModelCollection<ShapeModel>()
    var redoModels = ModelCollection<ShapeModel>()
    
    lazy var contentView: UIView = { [unowned self] by in
        let view = UIView(frame: bounds)
        view.clipsToBounds = true
        return view
        }(())
    
    var prevModel:LayerModel?
    
    lazy var resizerView:SPUserResizableView = { [unowned self] by in
        let resize = SPUserResizableView(frame: bounds)
        resize.minHeight = bounds.height * 0.1
        resize.minWidth = bounds.width * 0.1
        resize.preventsPositionOutsideSuperview = false
        resize.delegate = self
        
        return resize
        }(())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        superlayer = BlankBackingLayer()
        initialize()
    }
    var model:ShapeModel = ShapeModel.default(){
        didSet{
            updateShape(model.style)
            if model.isGradient {
                guard let grad = model.gradient else {return}
                if let layer = superlayer as? BackingGradientlayer{
                    layer.model = grad
                }else{
                    superlayer = BackingGradientlayer()
                    (superlayer as! BackingGradientlayer).model = grad
                }
                
            }else{
                guard let solid = model.solid else {return}
                if let layer = superlayer as? BlankBackingLayer{
                    layer.model = solid
                }else{
                    superlayer = BlankBackingLayer()
                    (superlayer as! BlankBackingLayer).model = solid
                }
            }
        }
    }
    
    private func updateShape(_ style:Style){
        superlayer.masksToBounds = true
        superlayer.roundCorners(style.maskedCorners, radius: style.cornerRadius)
        superlayer.borderWidth = style.borderWidth
        superlayer.borderColor = style.borderColor.cgColor
        
        /*contentView.*/layer.shadowColor = style.shadowColor.cgColor
        /*contentView.*/layer.shadowRadius = style.shadowRadius
        /*contentView.*/layer.shadowOpacity = style.shadowOpacity
        /*contentView.*/layer.shadowOffset = style.shadowOffset
        
    }
    
    func updateModel(_ model:ShapeModel){

        self.model = model

    }
    
    
    var id:String{
        if let _ = superlayer as? BackingGradientlayer{
            return "View \(id_tag): Gradient"
        }else{
            return "View \(id_tag)"
        }
    }
    var grd_tag:Int = 0
    var blk_tag = 0
    var id_tag: Int{
        if let _ = superlayer as? BackingGradientlayer{return grd_tag}
        return blk_tag
    }
    
    let uid:UUID = UUID()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize(){
        backgroundColor = .clear
        resizerView.contentView = contentView
        resizerView.hideEditingHandles()
        addSubview(resizerView)
        //contentView.layer.masksToBounds = true
        contentView.layer.addSublayer(superlayer)
        superlayer.needsDisplayOnBoundsChange = true
        superlayer.bounds = contentView.layer.bounds
        superlayer.position = [contentView.bounds.midX,contentView.bounds.midY]

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        superlayer.frame = contentView.bounds
        
        CATransaction.commit()
    }
}


//extension RectView:StateChangeable{
//
//    func stateRedo() {
//        if isGradient{
//            guard !redoGradientModels.isEmpty else {
//                Subscription.main.post(suscription: .canRedo, object: false)
//                return
//            }
//            let model = redoGradientModels.pop()
//            self.model = model
//        }else{
//            guard !redoBlankModels.isEmpty else {
//                Subscription.main.post(suscription: .canRedo, object: false)
//                return
//            }
//            let model = redoBlankModels.pop()
//            self.model = model
//        }
//    }
//
//    func stateUndo() {
//        if isGradient{
//            guard !previousGradientModels.isEmpty else{
//                Subscription.main.post(suscription: .canUndo, object: false)
//                return
//            }
//            let model = previousGradientModels.pop()
//            self.model = model
//            redoGradientModels.push(model!)
//        }else{
//            guard !previousBlankModels.isEmpty else{
//                Subscription.main.post(suscription: .canUndo, object: false)
//                return
//            }
//            let model = previousBlankModels.pop()
//            self.model = model
//            redoBlankModels.push(model!)
//        }
//        Subscription.main.post(suscription: .canRedo, object: true)
//    }
//}


extension RectView:BaseViewSubViewable{
    
    func focused(_ bool:Bool){
        bool ? resizerView.showEditingHandles() : resizerView.hideEditingHandles()
    }
}


extension RectView:SPUserResizableViewDelegate{
    
    func userResizableViewDidBeginEditing(_ userResizableView: SPUserResizableView!) {
        if let superview = superview as? BaseView, superview.selectedView != self {
            superview.selectedView = self
        }
        userResizableView.showEditingHandles()
    }
    
    func userResizableViewDidEndEditing(_ userResizableView: SPUserResizableView!) {
        self.frame.size = resizerView.frame.size
        //print("The new frame is: \(resizerView.frame)")
        self.frame.origin = self.frame.origin + resizerView.frame.origin
        resizerView.frame.origin = .zero
        model.layerFrame = makeLayerFrame()
        
    }
}


extension RectView:ShapableView{
    
    func layerChanged(_ isGradient: Bool) {
        if model.isGradient && isGradient{return}
        if isGradient && !model.isGradient{
            let layer = BackingGradientlayer()
            contentView.layer.replaceSublayer(superlayer, with: layer)
            superlayer = layer
            model.isGradient = isGradient
            layoutSubviews()
            //superlayer.setNeedsLayout()
            return
        }
        if !isGradient && model.isGradient{
            let layer = BlankBackingLayer()
            contentView.layer.replaceSublayer(superlayer, with: layer)
            superlayer = layer
            layoutSubviews()
            model.isGradient = isGradient
            return
        }
        if !isGradient && model.isGradient{return}
    }
}
