//
//  StylingPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class StylingPanel:MaterialView{
    
    lazy var scrollView: UIScrollView = {
        return .panelScrollView()
    }()
    
    lazy var contentView:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    lazy var header:BasicLabel = {
        let lab = BasicLabel.basicHeader()
        lab.text = "Styling"
        lab.textColor = .primary
        return lab
    }()
    
    lazy var cornerlable:BasicLabel = {
        return .basicLabel("Corners")
    }()
    
    lazy var cornerRadius:BasicLabel = {
        return .basicLabel("Radius")
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
        return .basicLabel("Borders")
    }()
    
    lazy var borderWidth:BasicLabel = {
        return .basicLabel("Width")
    }()
    
    lazy var borderColor:BasicLabel = {
        return .basicLabel("Color")
    }()
    
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
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        contentView.addSubview(thirdline)
        contentView.addSubview(cornerlable)
        contentView.addSubview(cornerRadius)
        contentView.addSubview(borderText)
        contentView.addSubview(borderColor)
        contentView.addSubview(borderWidth)
        contentView.addSubview(shadowText)
        contentView.addSubview(shadowColor)
        contentView.addSubview(shadowOpacity)
        contentView.addSubview(shadowX)
        contentView.addSubview(shadowY)
        contentView.addSubview(shadowRadius)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
                
        ])
    }
}
