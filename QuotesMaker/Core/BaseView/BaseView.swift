//
//  BaseView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 01/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class BaseView:UIView{
    
    typealias BaseSubView = UIView & BaseViewSubViewable & NSCopying
    
    
    
    typealias ViewTags = (imgs:Int,txt:Int,blk:Int,grd:Int)
    var viewTags:ViewTags = (0,0,0,0)
       
    var subIndex:CGFloat = 0
    
    var subBounds:CGRect{
        return CGRect(origin: [(bounds.size.width - bounds.size.scaledBy(0.7).width) / 2,(bounds.size.height - bounds.size.scaledBy(0.7).height) / 2 ], size: bounds.size.scaledBy(0.7))
    }
    
    var textBound:CGRect{
        let bounds = subBounds
        return [bounds.origin.x,bounds.origin.y,bounds.width,(bounds.height * 0.5)]
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var resizingMode:Bool = false
    
   
    
    private var current:CALayer?
    
    var selectedView:UIView?{
        didSet{
            currentSubview = selectedView as? BaseView.BaseSubView
            if oldValue != selectedView {
                if let old = oldValue as? BaseSubView{
                    old.focused(false)
                }
                
            }
        }
    }
    
    
    weak var delegate:BaseViewProtocol?
    
    var currentSubview:BaseSubView?{
        didSet{
            if currentSubview != nil{
                currentSubview?.focused(true)
            }
            Subscription.main.post(suscription: .activatedLayer, object: currentSubview)
        }
    }
    
    
    
    

    
    func invalidateLayers(){
        subviews.forEach{$0.removeFromSuperview()}
        currentSubview = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
//    func focusDidChange(){
//        let _ = subviews.map{$0.layer.borderColor = UIColor.clear.cgColor}
//    }
    
    func setup(){
        
        backgroundColor = .white
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.borderColor = UIColor.primary.cgColor
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        subscribeTo(subscription: .layerReArranged, selector: #selector(layerArranged(_:)))
    }
    
    @objc func layerArranged(_ notification:Notification){
        if let swap = notification.userInfo?[.info] as? LayerStack.SwapIndice{
            exchangeSubview(at: swap.initial, withSubviewAt: swap.final)
        }
    }
    
    

    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addSubviewable(_ view:BaseSubView, center:Bool = true){
        if center{
            view.center = [bounds.midX,bounds.midY]
        }
        subIndex += 1
        view.setIndex(subIndex)
        addSubview(view)
        selectedView = view
    }
    
    

    
    
    deinit {
        unsubscribe()
    }
    
    func moveSubiewForward(){
        guard let current = currentSubview, let subViewIndex = subviews.firstIndex(of: current) else {return}
        if subViewIndex + 1 < subviews.endIndex{
            exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex + 1)
            Subscription.main.post(suscription: .layerChanged, object: subviews)
        }
        
        
    }
    
    func moveSubiewBackward(){
        guard let current = currentSubview, let subViewIndex = subviews.firstIndex(of: current) else {return}
        if subViewIndex > subviews.startIndex{
            exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex - 1)
            Subscription.main.post(suscription: .layerChanged, object: subviews)
        }
        
    }
    
    
    func makeImageFromView(scale:CGFloat = UIScreen.main.scale)->UIImage?{
        currentSubview?.focused(false)
        layer.borderColor = UIColor.clear.cgColor
        UIGraphicsBeginImageContextWithOptions(bounds.size,isOpaque,scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        layer.borderColor = UIColor.primary.cgColor
        return image
    }
    
    func propagateFocus(current:BaseSubView){
        subviews.forEach{ view in
            if let view = view as? BaseSubView {
                if view !== current{
                    current.focused(false)
                    
                }
            }
        }
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        let subs = subviews.filter{$0 != subview}
        Subscription.main.post(suscription: .layerChanged, object: subs)
        
    }
    
    
    override func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        if let subOne = subviews[index1] as? BaseSubView, let subTwo = subviews[index2] as? BaseSubView{
            let i1 = subOne.getIndex; let i2 = subTwo.getIndex
            subOne.setIndex(i2)
            subTwo.setIndex(i1)
        }
        super.exchangeSubview(at: index1, withSubviewAt: index2)
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        if let view = subview as?  BackingImageView{
            viewTags.imgs += 1
            view.id_tag = viewTags.imgs
        }else if let view = subview as? BackingTextView{
            viewTags.txt += 1
            view.id_tag = viewTags.txt
        }else if let view = subview as? RectView{
            if let _ = view.superlayer as? BackingGradientlayer{
                viewTags.grd += 1
                view.grd_tag = viewTags.grd
            }
            else{
                viewTags.blk += 1
                view.blk_tag = viewTags.blk
                
            }
        }
        //currentSubview = subview as? BaseView.BaseSubView
        Subscription.main.post(suscription: .layerChanged, object: subviews)
    }
    
    
}


extension BaseView{
    
    func save(){
        
//        let savedData = subviews.compactMap { sub -> LayerModel? in
//            if let subview = sub as? WrapperView{
//                subview.model.layerFrame(subview.makeLayerFrame())
//                return subview.model
//            }
//            if let subview = sub as? BackingImageView{
//                subview.model.layerFrame(subview.makeLayerFrame())
//                return subview.model
//            }
//            
//            if let subview = sub as? BackingTextView{
//                subview.model.layerFrame(subview.makeLayerFrame())
//                return subview.model
//            }
//            return nil
//        }
        
        //print("This is the saved data: \(savedData)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Nothing happenng here")
        //scrollValue = true
    }
}





