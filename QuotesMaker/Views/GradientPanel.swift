//
//  GradientOptionsView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

//Height = 200

protocol GradientOptionsDelegate:class {
    
    func modelChanged(_ model:GradientLayerModel)
    func donePressed(_ model:GradientLayerModel)
}

class GradientPanel: MaterialView {
    
    lazy var doneButt:DoneButton = {
        let but = DoneButton(frame: .zero)
        return but
    }()
    
    @objc func done(_ sender:UIButton){
        delegate?.donePressed(model)
    }
    
    lazy var titleLable:BasicLabel = {
        let lable = BasicLabel(frame: .zero)
        lable.text = "Customize Gradients"
        return lable
    }()
    var designtedAlphas:[CGFloat] = [1,1,1,1]
    lazy var parent:UIView = {
        let v = UIView(frame: frame)
        v.backgroundColor = .white
        return v
    }()

    lazy var alphaSlider:AlphaSliderView = {
        let alpha = AlphaSliderView(frame: .zero)
        alpha.slider.value = 1
        return alpha
    }()
    
    var workingIndex = 0
    private var model:GradientLayerModel!
    weak var delegate:GradientOptionsDelegate?
    private let insets:CGFloat = 12
    private let horizontalmargin:CGFloat = 8
    private let verticalMargin:CGFloat = 16
    
    lazy var stepperTitle:BasicLabel = {
        let lable = BasicLabel(frame: .zero)
        lable.text = "Add / Remove Colors"
        lable.font = .systemFont(ofSize: 16, weight: .regular)
        return lable
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
    
    lazy var gradientSegments:UISegmentedControl = {
        let segment = UISegmentedControl(frame: .zero)
        segment.insertSegment(withTitle: "1", at: 0, animated: true)
        segment.insertSegment(withTitle: "2", at: 1, animated: true)
        segment.tintColor = .gray
        segment.selectedSegmentIndex = 0
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
        clipsToBounds = false
        model = GradientLayerModel.defualt()
        backgroundColor = .white
        parent.clipsToBounds = true
        addSubview(parent)
        parent.addSubview(scrollView)
        parent.addSubview(titleLable)
        parent.addSubview(doneButt)
        scrollView.addSubview(contentView)
        contentView.addSubview(gradientSegments)
        contentView.addSubview(stepperTitle)
        contentView.addSubview(stepper)
        contentView.addSubview(colorSlider)
        contentView.addSubview(locationTitle)
        contentView.addSubview(locationSlider)
        contentView.addSubview(alphaSlider)
        gradientSegments.addTarget(self, action: #selector(gradSegmentChanged(_:)), for: .valueChanged)
        colorSlider.addTarget(self, action: #selector(colorSliderChanged(_:)), for: .valueChanged)
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
        locationSlider.addTarget(self, action: #selector(locationSliderChanged(_:)), for: .valueChanged)
        alphaSlider.slider.addTarget(self, action: #selector(alphaChanged(_:)), for: .valueChanged)
        doneButt.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
    }
    
    @objc func alphaChanged(_ sender:UISlider){
        let newAlpha:CGFloat = CGFloat(sender.value)
        designtedAlphas[workingIndex] = newAlpha
        let currentColor = model.colors[workingIndex]
        model.colors[workingIndex] = UIColor(cgColor: currentColor).withAlphaComponent(newAlpha).cgColor
        delegate?.modelChanged(model)
    }
    
    @objc func gradSegmentChanged(_ sender:UISegmentedControl){
        workingIndex = sender.selectedSegmentIndex
        alphaSlider.slider.setValue(Float(designtedAlphas[workingIndex]), animated: true)
        locationSlider.setValue(Float(truncating: model.locations[workingIndex]), animated: true)
        //sender.tintColor = UIColor(cgColor: model.colors[workingIndex])
    }
    
    @objc func colorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.colors[workingIndex] =  color.withAlphaComponent(designtedAlphas[workingIndex]).cgColor
        //gradientSegments.tintColor = UIColor(cgColor: model.colors[workingIndex])
        delegate?.modelChanged(model)
    }
    
    @objc func stepperChanged(_ sender:UIStepper){
        
        let newIndex = Int(sender.value)
        guard newIndex < 5 else{return}
        if newIndex < gradientSegments.numberOfSegments{
            gradientSegments.removeSegment(at: newIndex, animated: true)
            model.colors.removeLast()
            model.locations.removeLast()
            updateWorkingIndex(newIndex: newIndex)
        }else{
            gradientSegments.insertSegment(withTitle: "\(newIndex)", at: newIndex - 1, animated: true)
            model.colors.append(GradientLayerModel.originalColor)
            model.addLocation(at: newIndex)
        }
        delegate?.modelChanged(model)
        
    }
    
    func updateWorkingIndex(newIndex:Int){
        if workingIndex >= newIndex{workingIndex = newIndex - 1}
    }
    
    @objc func locationSliderChanged(_ slider:UISlider){
        model.locations[workingIndex] =  NSNumber(value: slider.value)
        delegate?.modelChanged(model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        parent.translatesAutoresizingMaskIntoConstraints = false
        parent.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        let priorityC = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        priorityC.priority = .defaultLow
        NSLayoutConstraint.activate([
            parent.topAnchor.constraint(equalTo: topAnchor, constant:4),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-4),
            parent.leadingAnchor.constraint(equalTo: leadingAnchor, constant:4),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-4),
            titleLable.topAnchor.constraint(equalTo: parent.topAnchor, constant: insets),
            titleLable.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            doneButt.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -verticalMargin),
            doneButt.topAnchor.constraint(equalTo: parent.topAnchor, constant: insets),
            doneButt.heightAnchor.constraint(equalToConstant: 25),
            doneButt.widthAnchor.constraint(equalToConstant: 60),
            scrollView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: verticalMargin),
            scrollView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: parent.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            priorityC,
            gradientSegments.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: frame.height),
            gradientSegments.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            gradientSegments.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            gradientSegments.heightAnchor.constraint(equalToConstant: 28),
            stepperTitle.topAnchor.constraint(equalTo: gradientSegments.bottomAnchor, constant: verticalMargin),
            stepperTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            stepper.topAnchor.constraint(equalTo: gradientSegments.bottomAnchor, constant: verticalMargin),
            stepper.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -insets),
            stepper.heightAnchor.constraint(equalToConstant: 20),
            //stepper.widthAnchor.constraint(equalToConstant: 40),
            colorSlider.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: verticalMargin),
            colorSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            colorSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            colorSlider.heightAnchor.constraint(equalToConstant: 20),
            alphaSlider.topAnchor.constraint(equalTo: colorSlider.bottomAnchor, constant:verticalMargin),
            alphaSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            alphaSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            alphaSlider.heightAnchor.constraint(equalToConstant: 60),
            locationTitle.topAnchor.constraint(equalTo: alphaSlider.bottomAnchor, constant: verticalMargin),
            locationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            locationSlider.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: verticalMargin),
            locationSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            locationSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            locationSlider.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        
    }

}
