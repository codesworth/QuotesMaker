
//
//  StudioEditorView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 22/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit




class StudioEditorView:UIView{
    
    
    enum ZoomScale:CGFloat {
        case minimum = 0.8
        case `default` = 1
        case max = 4
    }
    
    private lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = true
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize(){
        backgroundColor = .red
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        borderlize(.primary, 1)
    }
    
    func addCanvas(_ base:BaseView){
        contentView.addSubview(base)
        let size = base.frame.size
        base.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            base.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            base.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            base.widthAnchor.constraint(equalToConstant: size.width),
            base.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size:CGSize
        if __IS_IPAD{
            size = Dimensions.editorSize
        }else{size = .zero}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //let scrollCons = scrollView.pinAllSides()
        if bounds.height == 0 {return}
        print("The height is: \(bounds.height)")
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant:bounds.height),
        ])
        
        
    }
    
}


extension StudioEditorView:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        //print("Scrolling with: \(view)")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        guard let baseView = contentView.subviews.first(where: { v -> Bool in
            return type(of: v) == BaseView.self
        }) else {return}
        baseView.center = center
        
    }
}
