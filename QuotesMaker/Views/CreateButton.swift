//
//  CreateButton.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class CreateButton:UIButton{
    
    var addIcon:CAShapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addIcon.path = Utils.drawAddInRect().cgPath
        addIcon.position = center
        layer.addSublayer(addIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
