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
    //var ovalLayer = CAShapeLayer()
    var superlayer:CALayer!
    var oldModel:ShapeModel = .default()
    
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
            //updateLayerFrame(model: model)
            if model.isGradient {
                guard let grad = model.gradient else {return}
                if let layer = superlayer as? BackingGradientlayer{
                    layer.model = grad
                }else{
                    let layer = BackingGradientlayer()
                    contentView.layer.replaceSublayer(superlayer, with: layer)
                    superlayer = layer
                    layoutSubviews()
                    (superlayer as! BackingGradientlayer).model = grad
                }
                
            }else{
                guard let solid = model.solid else {return}
                if let layer = superlayer as? BlankBackingLayer{
                    layer.model = solid
                }else{
                    let layer = BlankBackingLayer()
                    contentView.layer.replaceSublayer(superlayer, with: layer)
                    superlayer = layer
                    layoutSubviews()
                    (superlayer as! BlankBackingLayer).model = solid
                }
            }
        }
    }
    
    func updateLayerFrame(model:ShapeModel){
        guard let lframe = model.layerFrame, let sup = superview else {return}
        let frame = lframe.awakeFrom(bounds: sup.bounds)
        self.frame = frame
        resizerView.frame = bounds
    }
    
    
    
    private func updateShape(_ style:Style){
        superlayer.masksToBounds = true
        let radius = (style.cornerRadius > bounds.size.min) ? bounds.size.min : style.cornerRadius
        superlayer.roundCorners(style.maskedCorners, radius: radius)
        superlayer.borderWidth = style.borderWidth
        superlayer.borderColor = style.borderColor.cgColor
        //print("The angle is: \(CGFloat.Angle(style.rotationAngle))")
//        print("The frame before \(contentView.frame)")
//        let transform = CGAffineTransform(rotationAngle: .Angle(style.rotationAngle))
//        resizerView.transform = transform
//
//        print("The frame after \(contentView.frame)")
        //resizerView.sizeToFit()
        /*contentView.*/layer.shadowColor = style.shadowColor.cgColor
        /*contentView.*/layer.shadowRadius = style.shadowRadius
        /*contentView.*/layer.shadowOpacity = style.shadowOpacity
        /*contentView.*/layer.shadowOffset = style.shadowOffset
        
    }
    
    func updateModel(_ model:ShapeModel){
        oldModel = self.model
        //let state = State(model: oldModel, action: .nothing)
        //Subscription.main.post(suscription: .stateChange, object: state)
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
        //setPanGesture()
        backgroundColor = .clear
        resizerView.contentView = contentView
        resizerView.hideEditingHandles()
        addSubview(resizerView)
        //contentView.layer.masksToBounds = true
        //contentView.layer.addSublayer(ovalLayer)
        //ovalLayer.masksToBounds = true
        //ovalLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        //ovalLayer.addSublayer(superlayer)
        superlayer.needsDisplayOnBoundsChange = true
        superlayer.bounds = contentView.layer.bounds
        //ovalLayer.position = [contentView.bounds.midX,contentView.bounds.midY]
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let _ = superview{
            oldModel.layerFrame = makeLayerFrame()
        }
    }
    

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        superlayer.frame = contentView.bounds
        if model.style.cornerRadius > self.contentView.bounds.size.min{
            var style = model.style
            style.cornerRadius = self.contentView.bounds.size.min
            updateShape(style)
        }else{
           updateShape(model.style)
        }
        CATransaction.commit()
    }
    
    
}

extension RectView:NSCopying{
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = RectView(frame: frame)
        copy.contentView = contentView
        copy.model = model
        return copy
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
    var layerModel: LayerModel {
        return model
    }

    
    
    func setIndex(_ index: CGFloat) {
        model.layerIndex = index
    }
    
    var getIndex:CGFloat{
        return model.layerIndex
    }
    
    func focused(_ bool:Bool){
        bool ? resizerView.showEditingHandles() : resizerView.hideEditingHandles()
    }
}


extension RectView:SPUserResizableViewDelegate{
    
    func userResizableViewDidBeginEditing(_ userResizableView: SPUserResizableView!) {
        self.gestureRecognizers?.forEach{$0.cancelsTouchesInView = true}
        if let superview = superview as? BaseView {
            superview.selectedView = self
        }
        
        userResizableView.showEditingHandles()
    }
    
    func userResizableViewDidEndEditing(_ userResizableView: SPUserResizableView!) {
        self.frame.size = resizerView.frame.size
        //print("The new frame is: \(resizerView.frame)")
        
        self.frame.origin = self.frame.origin + resizerView.frame.origin
        resizerView.frame.origin = .zero
        let old = model.layerFrame
        if old == makeLayerFrame(){return}
        model.layerFrame = makeLayerFrame()
        if model.layerFrame != oldModel.layerFrame{
            Subscription.main.post(suscription: .stateChange, object: State(model: oldModel, action: .nothing))
        }
        
       Subscription.main.post(suscription: .roundedCornerRadiusValueChanged, object: contentView.bounds.size.min)
        
    }
    
    func postFrameChange(old:LayerModel,new:LayerModel){
        
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
