//
//  PointControlPad.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PointControlPad: UIView {
    
    
    lazy var pointControl:UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: 20))
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        return view
    }()
    
    private var panGesture:UIPanGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit(){
        backgroundColor = .white
        addSubview(pointControl)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        pointControl.center = center
        pointControl.addGestureRecognizer(panGesture!)
        
    }
    
    func setControlTo(_ point:CGPoint){
        
    }
    
    @objc func panned(_ recognizer:UIPanGestureRecognizer){
        
    }

}
