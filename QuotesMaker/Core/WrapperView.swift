
//
//  WrapperView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class WrapperView: UIView{
    
    var superlayer:CALayer!
    var isGradient = false
    var previousBlankModels = ModelCollection<BlankLayerModel>()
    var redoBlankModels = ModelCollection<BlankLayerModel>()
    var previousGradientModels = ModelCollection<BlankLayerModel>()
    var redoGradientModels = ModelCollection<BlankLayerModel>()
    
    lazy var contentView: UIView = { [unowned self] by in
        let view = UIView(frame: bounds)
        view.clipsToBounds = true
        return view
    }(())
    
    
    
    lazy var resizerView:SPUserResizableView = { [unowned self] by in
        let resize = SPUserResizableView(frame: bounds)
                resize.minHeight = bounds.height * 0.1
                resize.minWidth = bounds.width * 0.1
                resize.preventsPositionOutsideSuperview = false
        resize.delegate = self
        
        return resize
    }(())
    
    init(frame: CGRect, layer:CALayer) {
        super.init(frame: frame)
        superlayer = layer
        if type(of: layer) == BackingGradientlayer.self{
            isGradient = true
            updateModel(GradientLayerModel.defualt())
        }else{
            updateModel(BlankLayerModel())
        }
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
                    (superlayer as! BlankBackingLayer).model = mod
                }
            }
        }
    }
    
    func updateModel(_ model:LayerModel){
        self.model = model
        if let mod = model as? BlankLayerModel
        Subscription.main.post(suscription: .canUndo, object: previousModels.isMulti)
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
        contentView.layer.masksToBounds = true
        contentView.layer.addSublayer(superlayer)
        superlayer.needsDisplayOnBoundsChange = true
        superlayer.bounds = contentView.layer.bounds
        superlayer.position = [contentView.bounds.midX,contentView.bounds.midY]
//        setPanGesture()
//        setResizableGesture()
        
       doubleTappedGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        superlayer.frame = contentView.bounds
        
        CATransaction.commit()
    }
}


extension WrapperView:StateChangeable{
    
    func stateRedo() {
        guard !redoModels.isEmpty else {
            Subscription.main.post(suscription: .canRedo, object: false)
            return
        }
        let model = redoModels.pop()
        self.model = model
    }
    
    func stateUndo() {
        guard !previousModels.isEmpty else{
            Subscription.main.post(suscription: .canUndo, object: false)
            return
        }
        let model = previousModels.pop()
        self.model = model
        redoModels.push(model)
        Subscription.main.post(suscription: .canRedo, object: true)
    }
}


extension WrapperView:BaseViewSubViewable{
    
    func focused(_ bool:Bool){
        bool ? resizerView.showEditingHandles() : resizerView.hideEditingHandles()
    }
}


extension WrapperView:SPUserResizableViewDelegate{
    
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
        //print("The model is" ,model.layerFrame)
        //resizerView.hideEditingHandles()
    }
}
