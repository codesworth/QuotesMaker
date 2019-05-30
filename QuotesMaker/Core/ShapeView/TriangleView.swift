//
//  TriangleView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 30/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class TriangleShape:UIView{
    
    
}



class OvalView:UIView{
    
    private var shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialiaze()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialiaze(){
        layer.addSublayer(shapeLayer)
        let path = UIBezierPath(ovalIn: bounds)
        shapeLayer.path = path.cgPath
    }
    
    
}


