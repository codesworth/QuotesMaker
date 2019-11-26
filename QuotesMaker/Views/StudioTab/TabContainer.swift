//
//  TabContainer.swift
//  QuotesMaker
//
//  Created by Shadrach Mnsah on 26/11/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class TabContainer:UIView{
    
    lazy var studioTab:StudioTab = {
        let studio = StudioTab(frame: .zero)
        return studio
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .secondaryDark
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2
        layer.shadowOffset = [0,4]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(studioTab)
        studioTab.layout{
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
            $0.bottom == bottomAnchor
            $0.height |=| 40
        }
    }
    
    
}
