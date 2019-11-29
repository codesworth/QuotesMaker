//
//  ShadowView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


final class ShadowPanel:UIView{
    typealias Selectors = (color:Selector,radius:Selector,X:Selector,Y:Selector,alpha:Selector,colorChanging:Selector,alphaChanging:Selector)
    lazy var shadowText:BasicLabel = {
        let lab =  BasicLabel.basicLabel("Shadows")
        lab.font = .systemFont(ofSize: 16, weight: .regular)
        
        return lab
    }()
    
    lazy var shadowColor:BasicLabel = {
        let lab = BasicLabel.basicLabel("Color")
        
        return lab
    }()
    
    lazy var shadowX:BasicLabel = {
        let lab = BasicLabel.basicLabel("X: 0")
        
        return lab
    }()
    
    lazy var shadowY:BasicLabel = {
        let lab = BasicLabel.basicLabel("Y: 0")
        
        return lab
    }()
    
    lazy var shadowRadius:BasicLabel = {
        let lab = BasicLabel.basicLabel("Radius: 0")
        
        return lab
    }()
    
    lazy var shadowOpacityslider:UISlider = {
        let slider = UISlider(frame: .zero)
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.tintColor = .white
        slider.thumbTintColor = .primaryDark
        slider.value = 1
        return slider
    }()
    
    lazy var opacitylable:UILabel = {
        let lable = UILabel(frame: .zero)
        lable.font = .systemFont(ofSize: 14, weight: .thin)
        lable.text = "Opacity: 1"
        lable.textColor = .white
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
        backgroundColor = .secondaryDark
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
    
    func setTargets(object:Any, selectors:Selectors){
        colorSlider.addTarget(object, action: selectors.color, for: .touchUpInside)
        radiusStepper.addTarget(object, action: selectors.radius, for: .valueChanged)
        Xstepper.addTarget(object, action: selectors.X, for: .valueChanged)
        Ystepper.addTarget(object, action: selectors.Y, for: .valueChanged)
        shadowOpacityslider.addTarget(object, action: selectors.alpha, for: .touchUpInside)
        shadowOpacityslider.addTarget(object, action: selectors.alphaChanging, for: .valueChanged)
        colorSlider.addTarget(object, action: selectors.colorChanging, for: .valueChanged)
        
        
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
            print("i was called")
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
        shadowRadius.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowRadius.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shadowRadius.widthAnchor.constraint(equalToConstant: 100),
            shadowRadius.topAnchor.constraint(equalTo: radiusStepper.bottomAnchor, constant: 16),
        ])
//        shadowRadius.layout{
//            $0.leading == leadingAnchor + 20
//            $0.top == radiusStepper.bottomAnchor + 12
//            $0.width |=| 100
//        }
        
        Xstepper.layout{
            $0.top == divider.bottomAnchor + 30
            $0.centerX == centerXAnchor
            $0.width |=| 100
            $0.height |=| 20
        }
        
        shadowX.layout{
            $0.centerX == centerXAnchor
            $0.top == radiusStepper.bottomAnchor + 16
        }
        
        Ystepper.layout{
            $0.top == divider.bottomAnchor + 30
            $0.trailing == trailingAnchor - 16
            $0.width |=| 100
            $0.height |=| 20
        }
        
        shadowY.layout{
            $0.trailing == trailingAnchor - 16
            $0.top == radiusStepper.bottomAnchor + 16
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
