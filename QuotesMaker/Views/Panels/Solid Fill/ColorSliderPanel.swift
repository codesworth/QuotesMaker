//
//  ColorPickerView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol PickerColorDelegate:class {
    func colorDidChange(_ model:BlankLayerModel)
    func previewingWith(_ model: BlankLayerModel)
    
}

class ColorSliderPanel: MaterialView {
    
    lazy var doneButt:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    private var fireColorPreviewDelegation = true
    
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
    
    lazy var header:BasicLabel = {
        let h = BasicLabel(frame: .zero, font: .systemFont(ofSize: 18, weight: .medium))
        h.textColor = .primary
        h.text = "Styling"
        return h
    }()
    
    @objc func donePressed(){
        
        Utils.animatePanelsOut(self)
        unsubscribe()
    }
    
    lazy var lable:UILabel = {
        let lable = UILabel(frame: .zero)
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.text = "Set Background Color"
        lable.textColor = .black
        lable.textAlignment = .center
        return lable
    }()
    
    func update(with ref: BlankLayerModel?){
        if let ref = ref{
            fireColorPreviewDelegation = false
            colorSlider.color = ref.rawColor
            colorSlider.seekToColor(ref.rawColor)
            alphaSlider.slider.setValue(Float(ref.alpha), animated: true)
            //currentAlpha = ref.alpha
            model = ref
            fireColorPreviewDelegation = true
        }
    }
    
    var model:BlankLayerModel = BlankLayerModel()
    
    override var isHidden: Bool{
        didSet{
            if !isHidden{
                colorSlider.centerPreview(at: colorSlider.center)
            }
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
//        setNeedsLayout()
//        layoutIfNeeded()
       // colorSlider.color = model.color
       // colorSlider.layoutSubviews()
        //subscribeTo(subscription: .canUndo, selector: #selector(canUndo(_:)))
    }
    
//    @objc func canUndo(_ notification:Notification){
//        if let canundo = notification.userInfo?[.info] as? Bool{
//            stateControl.undoButt.isEnabled = canundo
//        }
//    }
    
    let alphaSlider = AlphaSliderView(frame: .zero)
    let colorSlider = ColorSlider(orientation: .horizontal, previewSide: .top)
    var currentColor:UIColor = .clear
    //var currentAlpha:CGFloat = 0.5
    weak var delegate:PickerColorDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }
    
    func commonSetup(){
        backgroundColor = .white
        addSubview(header)
        //addSubview(stateControl)
        colorSlider.addTarget(self, action: #selector(colorIsChanging(_:)), for: .valueChanged)
        colorSlider.addTarget(self, action: #selector(colorChanged(_:)), for: .touchUpInside)
        addSubview(colorSlider)
        addSubview(doneButt)
        alphaSlider.slider.addTarget(self, action: #selector(alphaChanging(_:)), for: .valueChanged)
        alphaSlider.slider.addTarget(self, action: #selector(alphaChanged(_:)), for: .touchUpInside)
        alphaSlider.slider.value = Float(model.alpha)
        addSubview(alphaSlider)
        addSubview(lable)
        //clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func colorChanged(_ slider:ColorSlider){
        print("Color is changed Coloris changed")
        currentColor = slider.color
        model.updateCcolor(currentColor)
        //model.color = slider.color.withAlphaComponent(currentAlpha)
        //model.alpha = currentAlpha
       // model.finalTouch = slider.restingLocation
        delegate?.colorDidChange(model)
    }
    
    @objc func colorIsChanging(_ slider:ColorSlider){
        print("Color is changing Coloris changing")
        if !fireColorPreviewDelegation{return}
        currentColor = slider.color
        model.updateCcolor(slider.color)
        //model.alpha = currentAlpha
        
        delegate?.previewingWith(model)
    }
    
    @objc func alphaChanged(_ slider:UISlider){
        print("Alpha is changed Alpha has changed")
        let value = CGFloat(slider.value)
        //currentAlpha = value
        //model.updateCcolor(currentColor)
        model.alpha = value
        delegate?.colorDidChange(model)
        
        
    }
    
    @objc func alphaChanging(_ slider:UISlider){
        print("Alpha is chamging Alpha is changing")
        let value = CGFloat(slider.value)
        //currentAlpha = value
        model.alpha = value
        delegate?.previewingWith(model)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            doneButt.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -16),
            doneButt.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            doneButt.heightAnchor.constraint(equalToConstant: 35),
            doneButt.widthAnchor.constraint(equalToConstant: 35),
//            stateControl.trailingAnchor.constraint(equalTo: doneButt.leadingAnchor, constant: -12),
//            stateControl.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            stateControl.widthAnchor.constraint(equalToConstant: 70),
//            stateControl.heightAnchor.constraint(equalToConstant: 30),
            colorSlider.topAnchor.constraint(equalTo: doneButt.bottomAnchor, constant: 12),
            colorSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant:12),
            colorSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-12),
            colorSlider.heightAnchor.constraint(equalToConstant: 20),
            lable.topAnchor.constraint(equalTo: colorSlider.bottomAnchor, constant: 8),
            lable.centerXAnchor.constraint(equalTo: centerXAnchor),
            alphaSlider.topAnchor.constraint(equalTo: lable.bottomAnchor, constant: 8),
            alphaSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            alphaSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            alphaSlider.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

}
