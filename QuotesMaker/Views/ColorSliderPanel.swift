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
    
    
}

class ColorSliderPanel: MaterialView {
    
    lazy var doneButt:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    @objc func donePressed(){
        Utils.animatePanelsOut(self)
    }
    
    lazy var lable:UILabel = {
        let lable = UILabel(frame: .zero)
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.text = "Set Background Color"
        lable.textColor = .black
        lable.textAlignment = .center
        return lable
    }()
    
    var model:BlankLayerModel = BlankLayerModel()
    
    override var isHidden: Bool{
        didSet{
            if !isHidden{
                colorSlider.centerPreview(at: colorSlider.center)
            }
        }
    }
    
    private let alphaSlider = AlphaSliderView(frame: .zero)
    private let colorSlider = ColorSlider(orientation: .horizontal, previewSide: .top)
    var currentColor:UIColor = .clear
    var currentAlpha:CGFloat = 0.5
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
        colorSlider.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)
        addSubview(colorSlider)
        addSubview(doneButt)
        alphaSlider.slider.addTarget(self, action: #selector(alphaChanged(_:)), for: .valueChanged)
        alphaSlider.slider.value = Float(currentAlpha)
        addSubview(alphaSlider)
        addSubview(lable)
        //clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func colorChanged(_ slider:ColorSlider){
        currentColor = slider.color
        model.color = slider.color.withAlphaComponent(currentAlpha)
        model.alpha = currentAlpha
        delegate?.colorDidChange(model)
    }
    
    @objc func alphaChanged(_ slider:UISlider){
        let value = CGFloat(slider.value)
        currentAlpha = value
        model.color = currentColor.withAlphaComponent(value)
        model.alpha = currentAlpha
        delegate?.colorDidChange(model)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            doneButt.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -16),
            doneButt.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            doneButt.heightAnchor.constraint(equalToConstant: 35),
            doneButt.widthAnchor.constraint(equalToConstant: 35),
            colorSlider.topAnchor.constraint(equalTo: doneButt.bottomAnchor, constant: 12),
            colorSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant:8),
            colorSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-8),
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
