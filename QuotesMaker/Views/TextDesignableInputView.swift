//
//  TextDesignableInputView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class TextDesignableInputView:UIView{
    
    lazy var titleLable:BasicLabel = {
        let lab = BasicLabel(frame: .zero, font: .systemFont(ofSize: 15, weight: .regular))
        lab.attributedText = NSAttributedString(string: "Fonts", attributes: [.underlineStyle:1])
        return lab
    }()
    
    lazy var fontCollectionview:UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: flow)
        col.backgroundColor = .clear
        return col
    }()
    
    lazy var fontSizeLable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Size"
        return lab
    }()
    
    lazy var fontColorLable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Color"
        return lab
    }()
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = true
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    lazy var contentView:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    lazy var fontSizeStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 4
        stepper.minimumValue = 2
        stepper.stepValue = 1
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var colorSlider:ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        return slider
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLable)
        contentView.addSubview(fontSizeLable)
        contentView.addSubview(fontSizeStepper)
        contentView.addSubview(fontColorLable)
        contentView.addSubview(colorSlider)
        contentView.addSubview(fontCollectionview)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 540),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fontCollectionview.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 12),
            fontCollectionview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            fontCollectionview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            fontCollectionview.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}


extension TextDesignableInputView{
    
}


//Font Type
//Font size
//Font Color
//Stroke Width
// underline
//strikethrough
