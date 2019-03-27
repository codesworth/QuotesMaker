//
//  StylingPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class StylingPanel:MaterialView{
    
    
    lazy var header:BasicLabel = {
        let lab = BasicLabel.basicHeader()
        lab.text = "Styling"
        lab.textColor = .primary
        return lab
    }()
    
    lazy var cornerlable:BasicLabel = {
        return BasicLabel.basicLabel("Corners")
    }()
    
    lazy var cornerRadius:BasicLabel = {
        return BasicLabel.basicLabel("Radius")
    }()
    
    
    lazy var firstline:LineView = {
        return .getLine()
    }()
    
    lazy var secondline:LineView = {
        return .getLine()
    }()
    
    lazy var thirdline:LineView = {
        return .getLine()
    }()
    
    lazy var borderText:BasicLabel = {
        return BasicLabel.basicLabel("Borders")
    }()
    
    lazy var borderWidth:BasicLabel = {
        return BasicLabel.basicLabel("Width")
    }()
    
    lazy var borderColor:BasicLabel = {
        return BasicLabel.basicLabel("Color")
    }()
    
    lazy var shadowText:BasicLabel = {
        return BasicLabel.basicLabel("Shadows")
    }()
    
    lazy var shadowColor:BasicLabel = {
        return BasicLabel.basicLabel("Color")
    }()
    
    lazy var shadowX:BasicLabel = {
        return BasicLabel.basicLabel("X")
    }()
    
    lazy var shadowY:BasicLabel = {
        return BasicLabel.basicLabel("Y")
    }()
    
    lazy var shadowRadius:BasicLabel = {
        return BasicLabel.basicLabel("Radius")
    }()
    
    lazy var shadowOpacity:BasicLabel = {
        return BasicLabel.basicLabel("Transparency")
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(){
        
    }
}
