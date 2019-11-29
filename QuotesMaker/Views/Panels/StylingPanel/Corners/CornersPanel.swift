//
//  CornersPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

final class CornersPanel:UIView{
    
    lazy var cornerlable:BasicLabel = {
        return .basicLabel("Corners")
    }()
    
    lazy var cornerRadius:BasicLabel = {
        return .basicLabel("Radius: 0")
    }()
    
    lazy var roundCornerView:CornerStack = {
        let corner = CornerStack(frame: .zero)
        return corner
    }()
    
    lazy var slider:UISlider = {
        let slider = UISlider(frame: .zero)
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.tintColor = .white
        slider.thumbTintColor = .primaryDark
        return slider
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerlable.layout {
            $0.top == topAnchor + 12
            $0.centerX == centerXAnchor
        }
        cornerRadius.layout{
            $0.top == cornerlable.bottomAnchor + 16
            $0.leading == leadingAnchor + 12
        }
        slider.layout{
            $0.leading == cornerRadius.trailingAnchor + 16
            $0.top == cornerlable.bottomAnchor + 12
            $0.trailing == trailingAnchor - 12
            $0.height |=| 20
        }
        
//        roundCornerView.layout{
//            $0.top == slider.bottomAnchor + 8
//            $0.leading == leadingAnchor
//            $0.trailing == trailingAnchor
//            $0.height |=| 100
//        }
    }
    
    
    func initialize(){
        backgroundColor = .secondaryDark
        addSubview(cornerlable)
        cornerlable.textColor = .white
        addSubview(cornerRadius)
        addSubview(slider)
        subscribeTo(subscription: .roundedCornerRadiusValueChanged, selector: #selector(cornerChanged(_:)))
        //addSubview(roundCornerView)
    }
    
    @objc func cornerChanged(_ notif:Notification){
        guard let radius = notif.userInfo?[.info] as? CGFloat else{return}
        slider.maximumValue = Float(radius)
        cornerRadius.text = "Radius: \(Int(radius))"
    }
    
}
