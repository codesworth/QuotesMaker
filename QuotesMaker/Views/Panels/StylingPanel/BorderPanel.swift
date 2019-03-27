//
//  BorderPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



final class BorderPanel:UIView{
    
    
    lazy var borderText:BasicLabel = {
        return .basicLabel("Borders")
    }()
    
    lazy var borderWidth:BasicLabel = {
        return .basicLabel("Width")
    }()
    
    lazy var borderColor:BasicLabel = {
        return .basicLabel("Color")
    }()
    
    lazy var widthStepper: UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.value = 0
        stepper.tintColor = .primary
        stepper.stepValue = 0.5
        
        return stepper
    }()
    
    lazy var colorSlider: ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
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
    
    
    func initialize(){
        addSubview(borderText)
        addSubview(borderColor)
        addSubview(borderWidth)
        addSubview(widthStepper)
        addSubview(colorSlider)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderText.layout{
            $0.top == topAnchor + 8
            $0.centerX == centerXAnchor
            
        }
        
        borderWidth.layout{
            $0.top == borderText.bottomAnchor + 8
            $0.leading == leadingAnchor + 8
            
        }
        
        borderColor.layout{
            $0.top == borderText.bottomAnchor + 8
            $0.trailing == trailingAnchor - 30
        }
        
        widthStepper.layout{
            $0.top == borderWidth.bottomAnchor + 8
            $0.leading == leadingAnchor + 16
            $0.width |=| 100
            $0.height |=| 20
        }
        
        colorSlider.layout{
            $0.top == borderColor.bottomAnchor + 8
            $0.leading == widthStepper.trailingAnchor + 12
            $0.trailing == trailingAnchor - 16
            $0.height |=| 20
        }
    }
}
