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
    
}

class GradientPanel: MaterialView {
    
    lazy var doneButt:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    @objc func donePressed(){
        Utils.animatePanelsOut(self)
        unsubscribe()
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //subscribeTo(subscription: .canUndo, selector: #selector(canUndo(_:)))
    }
    
//    @objc func canUndo(_ notification:Notification){
//        if let canundo = notification.userInfo?[.info] as? Bool{
//            stateControl.undoButt.isEnabled = canundo
//        }
//    }
    
    weak var stateDelegate:StateControlDelegate?
    
//    lazy var stateControl:StateChangeControl = {
//        let view = StateChangeControl(frame: .zero)
//        view.undoButt.addTarget(self, action: #selector(undo), for: .touchUpInside)
//        view.redoButt.addTarget(self, action: #selector(redo), for: .touchUpInside)
//        return view
//    }()
    
    @objc func undo(){
        stateDelegate?.stateChanged(.undo)
    }
    
    @objc func redo(){
        stateDelegate?.stateChanged(.redo)
    }
    
    lazy var controlPadView:PointControlView = {
        let pad = PointControlView(frame: .zero)
        pad.delegate = self
        return pad
    }()
    

    
    lazy var titleLable:BasicLabel = {
        let lable = BasicLabel(frame: .zero, font:.header)
        lable.text = "Customize Gradients"
        lable.textColor = .primary
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
        //parent.addSubview(stateControl)
        scrollView.addSubview(contentView)
        contentView.addSubview(gradientSegments)
        contentView.addSubview(stepperTitle)
        contentView.addSubview(stepper)
        contentView.addSubview(colorSlider)
        contentView.addSubview(locationTitle)
        contentView.addSubview(locationSlider)
        contentView.addSubview(alphaSlider)
        contentView.addSubview(controlPadView)
        gradientSegments.addTarget(self, action: #selector(gradSegmentChanged(_:)), for: .valueChanged)
        colorSlider.addTarget(self, action: #selector(colorSliderChanged(_:)), for: .valueChanged)
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
        locationSlider.addTarget(self, action: #selector(locationSliderChanged(_:)), for: .valueChanged)
        alphaSlider.slider.addTarget(self, action: #selector(alphaChanged(_:)), for: .valueChanged)
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
        if UIDevice.idiom == .pad{doneButt.isHidden = true}
        parent.translatesAutoresizingMaskIntoConstraints = false
        parent.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //let priorityC = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        //priorityC.priority = .defaultLow
        NSLayoutConstraint.activate([
            parent.topAnchor.constraint(equalTo: topAnchor, constant:4),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-4),
            parent.leadingAnchor.constraint(equalTo: leadingAnchor, constant:4),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-4),
            titleLable.topAnchor.constraint(equalTo: parent.topAnchor, constant: insets),
            titleLable.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20),
            
            doneButt.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -verticalMargin),
            doneButt.topAnchor.constraint(equalTo: parent.topAnchor, constant:8),
            doneButt.heightAnchor.constraint(equalToConstant: 35),
            doneButt.widthAnchor.constraint(equalToConstant: 35),
//            stateControl.trailingAnchor.constraint(equalTo: doneButt.leadingAnchor, constant: -12),
//            stateControl.topAnchor.constraint(equalTo: parent.topAnchor, constant: 12),
//            stateControl.widthAnchor.constraint(equalToConstant: 70),
//            stateControl.heightAnchor.constraint(equalToConstant: 30),
            scrollView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: parent.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 650),
            //priorityC,
            gradientSegments.topAnchor.constraint(equalTo: contentView.topAnchor),
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
            controlPadView.topAnchor.constraint(equalTo: locationSlider.bottomAnchor, constant: 8),
            controlPadView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            controlPadView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            controlPadView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        
    }

}


extension GradientPanel:IntemediaryPadDelegate{
    
    func receivedControlUpdate(_ point: CGPoint, at: Int) {
        if at == 0{
            model.startPoint = point
            delegate?.modelChanged(model)
        }else{
            model.endPoint = point
            delegate?.modelChanged(model)
        }
    }
}
