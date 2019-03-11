//
//  ImagePanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 11/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class ImagePanel: UIView {
    
    lazy var firstline:LineView = {
        let line = LineView(frame: .zero)
        return line
    }()
    
    lazy var secondline:LineView = {
        let line = LineView(frame: .zero)
        return line
    }()
    
    lazy var header:BasicLabel = {
        let label = BasicLabel(frame: .zero, font: .systemFont(ofSize: 16, weight: .medium))
        label.text = "Image Options"
        return label
    }()
    
    lazy var imageSelectionStack:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    lazy var pickFromGalleryButton:UIButton = {
        let butt = UIButton(frame: [0])
        butt.backgroundColor = .clear
        butt.tintColor = .primary
        butt.setTitle("Pick From Gallery", for: .normal)
        return butt
    }()
    
    lazy var pickFromInternetButton:UIButton = {
        let butt = UIButton(frame: [0])
        butt.backgroundColor = .clear
        butt.tintColor = .primary
        butt.setTitle("Pick From Internet", for: .normal)
        return butt
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
    
    func initialize(){
        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        imageSelectionStack.addArrangedSubview(pickFromGalleryButton)
        imageSelectionStack.addArrangedSubview(pickFromInternetButton)
        contentView.addSubview(imageSelectionStack)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor, constant: 12)
            header.centerXAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>, constant: <#T##CGFloat#>)
        ])
    }
}
