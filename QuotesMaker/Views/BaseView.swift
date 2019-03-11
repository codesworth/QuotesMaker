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
    
    private var viewTags:(imgs:Int,txt:Int) = (0,0)
    
    private var current:CALayer?
    
    
    var currentSublayer:CALayer?{
        get{
            return  current
        }
        set{
            current = newValue
        }
    }
    
    var subLayers:[CALayer]?{
        return layer.sublayers
    }
    
    func invalidateLayers(){
        layer.sublayers?.removeAll()
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
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.primary.cgColor
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
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
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        if type(of: view) == BackingImageView.self{
            viewTags.imgs += 1
        }
    }
    
    func moveSubiewForward(subview:UIView){
        guard subviews.contains(subview) else {return}
        let subViewIndex = subviews.firstIndex(of: subview)!
        exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex + 1)
        
    }
    
    func moveSubiewBackward(subview:UIView){
        guard subviews.contains(subview) else {return}
        let subViewIndex = subviews.firstIndex(of: subview)!
        exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex - 1)
        
    }
    
}
