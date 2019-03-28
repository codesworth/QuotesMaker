//
//  ShadowView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


final class ShadowPanel:UIView{
    lazy var shadowText:BasicLabel = {
        let lab =  BasicLabel.basicLabel("Shadows")
        lab.font = .systemFont(ofSize: 20, weight: .semibold)
        lab.textColor = .primary
        return lab
    }()
    
    lazy var shadowColor:BasicLabel = {
        let lab = BasicLabel.basicLabel("Color")
        lab.font = .systemFont(ofSize: 18, weight: .semibold)
        lab.textColor = .primary
        return lab
    }()
    
    lazy var shadowX:BasicLabel = {
        let lab = BasicLabel.basicLabel("X")
        lab.font = .systemFont(ofSize: 18, weight: .semibold)
        lab.textColor = .primary
        return lab
    }()
    
    lazy var shadowY:BasicLabel = {
        let lab = BasicLabel.basicLabel("Y")
        lab.font = .systemFont(ofSize: 18, weight: .semibold)
        lab.textColor = .primary
        return lab
    }()
    
    lazy var shadowRadius:BasicLabel = {
        let lab = BasicLabel.basicLabel("Radius")
        lab.font = .systemFont(ofSize: 18, weight: .semibold)
        lab.textColor = .primary
        return lab
    }()
    
    lazy var shadowOpacityslider:UISlider = {
        let slider = UISlider(frame: .zero)
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.tintColor = .primary
        return slider
    }()
    
    lazy var opacitylable:UILabel = {
        let lable = UILabel(frame: .zero)
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.text = "Opacity"
        lable.textColor = .primary
        lable.textAlignment = .center
        return lable
    }()
    
    lazy var divider:LineView = {
        let line = LineView(frame: .zero)
        line.backgroundColor = .charcoal
        return line
    }()
    
    lazy var divider2:LineView = {
        let line = LineView(frame: .zero)
        line.backgroundColor = .charcoal
        return line
    }()
    
    lazy var colorSlider:ColorSlider = {
        return ColorSlider(orientation: .horizontal, previewSide: .top)
    }()
    
    lazy var Xstepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.value = 0
        stepper.tintColor = .primary
        stepper.stepValue = 0.5
        return stepper
    }()
    
    lazy var Ystepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.value = 0
        stepper.tintColor = .primary
        stepper.stepValue = 0.5
        return stepper
    }()
    
    lazy var radiusStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.value = 0
        stepper.tintColor = .primary
        stepper.stepValue = 0.5
        return stepper
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
        addSubview(shadowText)
        addSubview(shadowColor)
        addSubview(shadowX)
        addSubview(shadowY)
        addSubview(divider)
        addSubview(divider2)
        addSubview(shadowRadius)
        addSubview(radiusStepper)
        addSubview(Xstepper)
        addSubview(Ystepper)
        addSubview(colorSlider)
        addSubview(shadowOpacityslider)
        addSubview(opacitylable)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowText.layout{
            $0.top == topAnchor + 12
            $0.centerX == centerXAnchor
        }
        shadowColor.layout{
            $0.leading == leadingAnchor + 20
            $0.top == shadowText.bottomAnchor + 12
        }
        
        colorSlider.layout{
            $0.leading == shadowColor.trailingAnchor + 32
            $0.trailing == trailingAnchor - 16
            $0.top == shadowText.bottomAnchor + 12
            $0.height |=| 20
        }
        
        divider.layout{
            $0.top == colorSlider.bottomAnchor + 30
            $0.leading == leadingAnchor + 30
            $0.trailing == trailingAnchor - 30
            $0.height |=| 0.5
        }
        
        radiusStepper.layout{
            $0.top == divider.bottomAnchor + 30
            $0.leading == leadingAnchor + 20
            $0.width |=| 100
            $0.height |=| 20
        }
        
        shadowRadius.layout{
            $0.leading == leadingAnchor + 20
            $0.top == radiusStepper.bottomAnchor + 12
            $0.width |=| 100
        }
        
        Xstepper.layout{
            $0.top == divider.bottomAnchor + 30
            $0.centerX == centerXAnchor
            $0.width |=| 100
            $0.height |=| 20
        }
        
        shadowX.layout{
            $0.centerX == centerXAnchor
            $0.top == radiusStepper.bottomAnchor + 12
        }
        
        Ystepper.layout{
            $0.top == divider.bottomAnchor + 30
            $0.trailing == trailingAnchor - 16
            $0.width |=| 100
            $0.height |=| 20
        }
        
        shadowY.layout{
            $0.trailing == trailingAnchor - 16
            $0.top == radiusStepper.bottomAnchor + 12
            $0.width |=| 100
        }
        
        
        divider2.layout{
            $0.top == shadowY.bottomAnchor + 30
            $0.leading == leadingAnchor + 30
            $0.trailing == trailingAnchor - 30
            $0.height |=| 0.5
        }
        opacitylable.layout{
            $0.top == divider2.bottomAnchor + 16
            $0.leading == leadingAnchor + 20
        }
        
        shadowOpacityslider.layout{
            $0.top == divider2.bottomAnchor + 16
            $0.leading == opacitylable.trailingAnchor + 20
            $0.trailing == trailingAnchor - 20
            $0.height |=| 20
        }
        
        
    }
    
}
