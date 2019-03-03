//
//  GradientOptionsView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class GradientOptionsView: UIView {
    
    lazy var titleLable:BasicLabel = {
        let lable = BasicLabel(frame: .zero)
        lable.text = "Customize Gradients"
        return lable
    }()
    
    private let insets:CGFloat = 12
    private let margin:CGFloat = 8
    
    lazy var stepperTitle:BasicLabel = {
        let lable = BasicLabel(frame: .zero)
        lable.text = "Add / Remove Colors"
        lable.font = .systemFont(ofSize: 16, weight: .regular)
        return lable
    }()
    
    lazy var gradientSegments:UISegmentedControl = {
        let segment = UISegmentedControl(frame: .zero)
        return segment
    }()
    
    lazy var stepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 4
        stepper.minimumValue = 2
        stepper.stepValue = 1
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var colorSlider:ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        return slider
    }()
    
    lazy var locationSlider:UISlider = {
       let slider  = UISlider(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isContinuous = true
        return slider
    }()
    
    lazy var locationTitle:BasicLabel = {
        let lable = BasicLabel(frame: .zero,font: .systemFont(ofSize: 16, weight: .regular))
        lable.text = "Set Gradient Location"
        return lable
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit(){
        addSubview(titleLable)
        addSubview(gradientSegments)
        addSubview(stepperTitle)
        addSubview(stepper)
        addSubview(colorSlider)
        addSubview(locationTitle)
        addSubview(locationSlider)
        gradientSegments.addTarget(self, action: #selector(gradSegmentChanged(_:)), for: .valueChanged)
        colorSlider.addTarget(self, action: #selector(colorSliderChanged(_:)), for: .valueChanged)
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
        locationSlider.addTarget(self, action: #selector(locationSliderChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func gradSegmentChanged(_ sender:UISegmentedControl){
        
    }
    
    @objc func colorSliderChanged(_ slider:ColorSlider){
        
    }
    
    @objc func stepperChanged(_ sender:UIStepper){
        
    }
    
    @objc func locationSliderChanged(_ slider:UISlider){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: insets),
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            gradientSegments.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: margin),
            gradientSegments.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            gradientSegments.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets),
            gradientSegments.heightAnchor.constraint(equalToConstant: 28),
            stepperTitle.topAnchor.constraint(equalTo: gradientSegments.bottomAnchor, constant: margin),
            stepperTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            stepper.topAnchor.constraint(equalTo: gradientSegments.bottomAnchor, constant: margin),
            stepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets),
            stepper.heightAnchor.constraint(equalToConstant: 25),
            stepper.widthAnchor.constraint(equalToConstant: 60),
            colorSlider.topAnchor.constraint(equalTo: stepperTitle.bottomAnchor, constant: margin),
            colorSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            colorSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets),
            colorSlider.heightAnchor.constraint(equalToConstant: 25),
            locationTitle.topAnchor.constraint(equalTo: colorSlider.bottomAnchor, constant: margin),
            locationTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            locationSlider.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: margin),
            locationSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            locationSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets),
            locationSlider.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}
