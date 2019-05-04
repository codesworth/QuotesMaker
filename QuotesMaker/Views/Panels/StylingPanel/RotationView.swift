//
//  RotationView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 04/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class RotationView: UIView {

    lazy var angleSlider:UISlider = {
        let slider = UISlider(frame: .zero)
        slider.isContinuous = true
        slider.maximumValue = 360
        slider.minimumValue = 0
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .primary
        
        return slider
    }()
    
    lazy var header:BasicLabel = {
        let label = BasicLabel.basicHeader()
        label.text = "Rotation Angle"
        return label
    }()
    
    lazy var startlabel:BasicLabel = {
        let label = BasicLabel.basicLabel("0")
        return label
    }()
    
    lazy var endlabel:BasicLabel = {
        let label = BasicLabel.basicLabel("360")
        return label
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
        addSubview(header)
        addSubview(startlabel)
        addSubview(endlabel)
        addSubview(angleSlider)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        header.layout{
            $0.top == topAnchor + 8
            $0.centerX == centerXAnchor
        }
        
        startlabel.layout{
            $0.leading == leadingAnchor + 4
            $0.top == header.bottomAnchor + 8
        }
        
        endlabel.layout{
            $0.leading == trailingAnchor - 8
            $0.top == header.bottomAnchor + 8
        }
        angleSlider.layout{
            $0.top == header.bottomAnchor + 8
            $0.leading == startlabel.trailingAnchor + 8
            $0.trailing == endlabel.leadingAnchor - 8
            $0.height |=| 20
        }
    }
}
