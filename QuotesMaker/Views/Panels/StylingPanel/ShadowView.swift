//
//  ShadowView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


final class ShadowPanel:UIView{
    lazy var shadowText:BasicLabel = {
        return .basicLabel("Shadows")
    }()
    
    lazy var shadowColor:BasicLabel = {
        return .basicLabel("Color")
    }()
    
    lazy var shadowX:BasicLabel = {
        return .basicLabel("X")
    }()
    
    lazy var shadowY:BasicLabel = {
        return .basicLabel("Y")
    }()
    
    lazy var shadowRadius:BasicLabel = {
        return .basicLabel("Radius")
    }()
    
    lazy var shadowOpacity:BasicLabel = {
        return .basicLabel("Transparency")
    }()
}
