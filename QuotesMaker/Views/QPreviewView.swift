//
//  PreviewView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 11/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class QPreviewView: MaterialView {
    
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
        let lab = BasicLabel(frame: .zero, font: .systemFont(ofSize: 22, weight: .thin))
        lab.text = "PREVIEW"
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
           doneButt.topAnchor.constraint(equalTo: topAnchor, constant: 16),
           doneButt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
           doneButt.widthAnchor.constraint(equalToConstant: 50),
           doneButt.heightAnchor.constraint(equalToConstant: 50),
           header.topAnchor.constraint(equalTo: topAnchor, constant: 16),
           header.centerXAnchor.constraint(equalTo: centerXAnchor),
           imageView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
           imageView.widthAnchor.constraint(equalToConstant: dimens.width),
           imageView.heightAnchor.constraint(equalToConstant: dimens.height),
           imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    

}
