//
//  PreviewView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 11/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class QPreviewView:UIView {
    
    lazy var overlayView:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        view.alpha = 0.5
        return view
    }()
    
    lazy var preview:MaterialView = {
        let view = MaterialView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    lazy var doneButt:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return butt
    }()
    
    lazy var imageView:UIImageView = {
        let imgv = UIImageView(frame: .zero)
        imgv.clipsToBounds = true
        imgv.contentMode = .scaleAspectFill
        return imgv
    }()
    
    lazy var header:BasicLabel = {
        let lab = BasicLabel(frame: .zero, font: .systemFont(ofSize: 22, weight: .medium))
        lab.text = "PREVIEW"
        lab.textColor = .primary
        return lab
    }()
    

    @objc func dismiss(){
       removeFromSuperview()
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func setImage(_ image:UIImage?){
        imageView.image = image
    }
   
    
    func initialize(){
        backgroundColor = .white
        addSubview(overlayView)
        addSubview(preview)
        addSubview(doneButt)
        addSubview(imageView)
        addSubview(header)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.roundCorners()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        let dimens = Dimensions.sizeForAspect(.square).scaledBy(0.9)
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leftAnchor.constraint(equalTo: leftAnchor),
            overlayView.rightAnchor.constraint(equalTo:     rightAnchor),
            preview.centerXAnchor.constraint(equalTo: centerXAnchor),
            preview.centerYAnchor.constraint(equalTo: centerYAnchor),
            preview.heightAnchor.constraint(equalToConstant: .fixedHeight * 0.8),
            preview.widthAnchor.constraint(equalToConstant: .fixedWidth),
           doneButt.topAnchor.constraint(equalTo: preview.topAnchor, constant: 12),
           doneButt.trailingAnchor.constraint(equalTo: preview.trailingAnchor, constant: -24),
           doneButt.widthAnchor.constraint(equalToConstant: 40),
           doneButt.heightAnchor.constraint(equalToConstant: 40),
           header.topAnchor.constraint(equalTo: preview.topAnchor, constant: 16),
           header.centerXAnchor.constraint(equalTo: centerXAnchor),
           imageView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
           imageView.widthAnchor.constraint(equalToConstant: dimens.width),
           imageView.heightAnchor.constraint(equalToConstant: dimens.height),
           imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    

}
