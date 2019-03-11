//
//  ImagePanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 11/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol ImagePanelDelegate :class {
    func didSelect(_ option:ImagePanel.PanelOptions)
}

class ImagePanel: MaterialView {
    
    enum PanelOptions{
        case gallery
        case online
    }
    
    lazy var firstline:LineView = {
        let line = LineView(frame: .zero)
        return line
    }()

    
    let height:CGFloat = 450
    
    lazy var secondline:LineView = {
        let line = LineView(frame: .zero)
        return line
    }()
    weak var delegate:ImagePanelDelegate?
    lazy var header:BasicLabel = {
        let label = BasicLabel(frame: .zero, font: .systemFont(ofSize: 16, weight: .medium))
        label.text = "Image Options"
        return label
    }()
    
    
    lazy var pickFromGalleryButton:UIButton = {
        let butt = UIButton(frame: [0])
        butt.backgroundColor = .clear
        butt.tintColor = .primary
        butt.setTitle("Pick From Gallery", for: .normal)
        butt.borderlize()
        return butt
    }()
    
    lazy var pickFromInternetButton:UIButton = {
        let butt = UIButton(frame: [0])
        butt.backgroundColor = .clear
        butt.tintColor = .primary
        butt.setTitle("Pick From Internet", for: .normal)
        butt.borderlize()
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
        backgroundColor = .white
        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        contentView.addSubview(pickFromGalleryButton)
        contentView.addSubview(pickFromInternetButton)
        pickFromGalleryButton.addTarget(self, action: #selector(pickImageFromGallery), for: .touchUpInside)
        pickFromGalleryButton.addTarget(self, action: #selector(pickImageFromInternet), for: .touchUpInside)
    }
    
    @objc func pickImageFromGallery(){
       delegate?.didSelect(.gallery)
    }
    
    @objc func pickImageFromInternet(){
        delegate?.didSelect(.online)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            header.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: height),
            pickFromGalleryButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            pickFromGalleryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pickFromGalleryButton.widthAnchor.constraint(equalToConstant: 100),
            pickFromGalleryButton.heightAnchor.constraint(equalToConstant: 100),
            pickFromInternetButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            pickFromInternetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            pickFromInternetButton.widthAnchor.constraint(equalToConstant: 100),
            pickFromInternetButton.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
}
