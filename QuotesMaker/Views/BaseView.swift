//
//  BaseView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 01/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class BaseView:UIView{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private var viewTags:(imgs:Int,txt:Int,blk:Int,grd:Int) = (0,0,0,0)
    
    private var current:CALayer?
    
    
    var currentSublayer:CALayer?{
        get{
            return  current
        }
        set{
            current = newValue
        }
    }
    
    weak var delegate:BaseViewProtocol?
    
    var currentSubview:UIView?
    
    var subLayers:[CALayer]?{
        return layer.sublayers
    }
    
    func invalidateLayers(){
        subviews.forEach{$0.removeFromSuperview()}
        current = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func focusDidChange(){
        let _ = subviews.map{$0.layer.borderColor = UIColor.clear.cgColor}
    }
    
    func setup(){
        backgroundColor = .white
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.primary.cgColor
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        let subs = subviews.filter{$0 != subview}
        Subscription.main.post(suscription: .layerChanged, object: subs)
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLayer(_ layer:CALayer){
        self.layer.addSublayer(layer)
        //layer.bounds = bounds
        current = layer
        layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
    }
    
    
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        if let view = subview as?  BackingImageView{
            viewTags.imgs += 1
            view.id_tag = viewTags.imgs
        }else if let view = subview as? BackingTextView{
            viewTags.txt += 1
            view.id_tag = viewTags.txt
        }else if let view = subview as? WrapperView{
            if let _ = view.superlayer as? BackingGradientlayer{
                viewTags.grd += 1
                view.grd_tag = viewTags.grd
            }
            else{
                viewTags.blk += 1
                view.blk_tag = viewTags.blk
                
            }
        }
        currentSubview = subview
        Subscription.main.post(suscription: .layerChanged, object: subviews)
    }
    
//    func transformViewTolayer(){
//        let textViews = subviews.compactMap { (view) -> BackingTextView? in
//            if type(of: view) == BackingTextView.self{
//                return view as? BackingTextView
//            }
//            return nil
//        }
//        textViews.forEach{
//            let textLayer = TextBackingLayer()
//            textLayer.frame = $0.frame
//            textLayer.model = $0.model
//            self.layer.addSublayer(textLayer)
//
//            $0.removeFromSuperview()
//            $0.frame = [0]
//        }
//
//    }
    
    
    func moveSubiewForward(){
        guard let current = currentSubview, let subViewIndex = subviews.firstIndex(of: current) else {return}
        if subViewIndex + 1 < subviews.endIndex{
            exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex + 1)
        }
        
        
    }
    
    func moveSubiewBackward(){
        guard let current = currentSubview, let subViewIndex = subviews.firstIndex(of: current) else {return}
        if subViewIndex > subviews.startIndex{
            exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex - 1)
        }
        
    }
    
    func makeImageFromView()->UIImage?{
        layer.borderColor = UIColor.clear.cgColor
        UIGraphicsBeginImageContextWithOptions(bounds.size,isOpaque, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        layer.borderColor = UIColor.primary.cgColor
        return image
    }
    
}


extension BaseView{
    
    func save(){
        
        let savedData = subviews.compactMap { sub -> LayerModel? in
            if let subview = sub as? WrapperView{
                subview.model.layerFrame(subview.makeLayerFrame())
                return subview.model
            }
            if let subview = sub as? BackingImageView{
                subview.model.layerFrame(subview.makeLayerFrame())
                return subview.model
            }
            
            if let subview = sub as? BackingTextView{
                subview.model.layerFrame(subview.makeLayerFrame())
                return subview.model
            }
            return nil
        }
        
        print("This is the saved data: \(savedData)")
    }
}
