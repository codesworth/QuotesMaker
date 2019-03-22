//
//  BaseView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 01/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class BaseView:UIView{
    
    typealias BaseSubView = UIView & BaseViewSubViewable
    
    var viewTags:BaseContentView.ViewTags{
        get{
            return contentView.viewTags
        }
        set{
            contentView.viewTags = newValue
        }
    }
    enum ZoomScale:CGFloat {
        case minimum = 0.8
        case `default` = 1
        case max = 3
    }
    
    private lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isScrollEnabled = true
        scroll.delegate = self
        scroll.minimumZoomScale = ZoomScale.minimum.rawValue
        scroll.zoomScale = ZoomScale.default.rawValue
        scroll.maximumZoomScale = ZoomScale.max.rawValue
        return scroll
        
    }()
    
    private lazy var contentView:BaseContentView = {
        let view = BaseContentView(frame: .zero)
        return view
    }()
    var subBounds:CGRect{
        return CGRect(origin: [(bounds.size.width - bounds.size.scaledBy(0.7).width) / 2,(bounds.size.height - bounds.size.scaledBy(0.7).height) / 2 ], size: bounds.size.scaledBy(0.7))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var resizingMode:Bool = false
    
   
    
    private var current:CALayer?
    
    var selectedView:UIView?{
        didSet{
            if oldValue != selectedView {
                if let old = oldValue as? BaseSubView{
                    old.focused(false)
                    currentSubview = selectedView as? BaseView.BaseSubView
                    
                }
            }
        }
    }
    
    
    weak var delegate:BaseViewProtocol?
    
    var currentSubview:BaseSubView?{
        get{
            return contentView.current
        }
        
        set{
            contentView.current = newValue
        }
    }
    
    
    

    
    func invalidateLayers(){
        contentView.subviews.forEach{$0.removeFromSuperview()}
        current = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
//    func focusDidChange(){
//        let _ = subviews.map{$0.layer.borderColor = UIColor.clear.cgColor}
//    }
    
    func setup(){
        scrollView.addSubview(contentView)
        addSubview(scrollView)
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
            contentView.exchangeSubview(at: swap.initial, withSubviewAt: swap.final)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //let scrollCons = scrollView.pinAllSides()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant:bounds.height),
        ])
    }
    

    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addSubviewable(_ view:BaseSubView){
        view.center = [bounds.midX,bounds.midY]
        contentView.addSubview(view)
    }
    
    

    
    
    deinit {
        unsubscribe()
    }
    
    func moveSubiewForward(){
        guard let current = currentSubview, let subViewIndex = contentView.subviews.firstIndex(of: current) else {return}
        if subViewIndex + 1 < contentView.subviews.endIndex{
            contentView.exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex + 1)
            Subscription.main.post(suscription: .layerChanged, object: contentView.subviews)
        }
        
        
    }
    
    func moveSubiewBackward(){
        guard let current = currentSubview, let subViewIndex = contentView.subviews.firstIndex(of: current) else {return}
        if subViewIndex > contentView.subviews.startIndex{
            contentView.exchangeSubview(at: subViewIndex, withSubviewAt: subViewIndex - 1)
            Subscription.main.post(suscription: .layerChanged, object: contentView.subviews)
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
    
    func propagateFocus(current:BaseSubView){
        contentView.subviews.forEach{ view in
            if let view = view as? BaseSubView {
                if view !== current{
                    current.focused(false)
                    
                }
            }
        }
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
}




extension BaseView:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print("Scrolling with: \(view)")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("Zoom Ended")
    }
}
