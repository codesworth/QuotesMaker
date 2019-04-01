//
//  AlphaSliderView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

//Height = 

class AlphaSliderView: UIView {
    
   lazy var slider:UISlider = {
        let slider = UISlider(frame: .zero)
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.isContinuous = true
        return slider
    }()
    
    lazy var lable:UILabel = {
        let lable = UILabel(frame: .zero)
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.text = "Set Opacity"
        lable.textColor = .black
        lable.textAlignment = .center
        return lable
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(slider)
        addSubview(lable)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        slider.translatesAutoresizingMaskIntoConstraints = false
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            slider.heightAnchor.constraint(equalToConstant: 20),
            lable.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            lable.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}
