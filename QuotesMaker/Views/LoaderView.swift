//
//  LoaderView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 26/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class LoaderView:UIView{
    
    var activity:UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialize(frame:frame)
    }
    
    func initialize(frame:CGRect){
        backgroundColor = UIColor.darkText
        alpha = 0.75
        activity = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        activity.center = center
        addSubview(activity)
        activity.style = .whiteLarge
        activity.startAnimating()
    }
    
    init(frame:CGRect,offset:CGFloat){
        super.init(frame: frame)
        backgroundColor = UIColor.darkText
        alpha = 0.75
        activity = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        activity.center = CGPoint(x: center.x, y: center.y - (100 - offset))
        addSubview(activity)
        activity.style = .whiteLarge
        
        activity.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
