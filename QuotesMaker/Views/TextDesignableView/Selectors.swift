//
//  Selectors.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension TextDesignableInputView{
    
    @objc func colorSliderChanging(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.textColor = color
        delegate?.didUpdateModel(model, false)
    }
    
    @objc func colorSliderChanged(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.textColor = color
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func fontSizeXhanged(_ stepper:UIStepper){
        if blockDelegation{return}
        let val = stepper.value
        fontSizeLable.text =  "Size: \(val)"
        let newFont = UIFont(name: model.font.fontName, size: CGFloat(val))!
        model.font = newFont
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func alignmentDidChange(_ sender:UISegmentedControl){
        let index = sender.selectedSegmentIndex
        model.alignment = index
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func strokecolorSliderChanged(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.strokeColor = color
        delegate?.didUpdateModel(model, true)
    }
    @objc func strokecolorSliderChanging(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.strokeColor = color
        delegate?.didUpdateModel(model, false)
    }
    @objc func strokeWidthCanged(_ stepper:UIStepper){
        if blockDelegation{return}
        let val = stepper.value
        strokeWidthLabel.text =  "Size: \(val)"
        model.strokeWidth = Int(val)
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func underlineStyleColorChanged(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.underlineColor = color
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func underlineStyleColorChanging(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.underlineColor = color
        delegate?.didUpdateModel(model, false)
    }
    
    @objc func underlineStyleChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        let val = stepper.value
        underlineStylelable.text = "Style: \(val)"
        model.underlineStyle = Int(val)
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func strikeThroughcolorSliderChanged(_ slider:ColorSlider){
        if blockDelegation{return}
        let color = slider.color
        model.strikeThroughColor = color
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func strikeThroughcolorSliderChanging(_ slider:ColorSlider){
           if blockDelegation{return}
           let color = slider.color
           model.strikeThroughColor = color
           delegate?.didUpdateModel(model,false)
       }
    
    @objc func strikeThroughStylehanged(_ stepper:UIStepper){
        if blockDelegation{return}
        let val = stepper.value
        strikeStyleLabel.text = "Style: \(val)"
        model.strikeThrough = Int(val)
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func obliquessChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        let val = stepper.value
        obliqStyleLabel.text = "Style: \(val)"
        model.obliquess = Int(val)
        delegate?.didUpdateModel(model, true)
    }
    
    func registrationsAndtargetSets(){
        fontCollectionview.register(UINib(nibName: "\(FontCells.self)", bundle: nil), forCellWithReuseIdentifier: "\(FontCells.self)")
        fontCollectionview.register(UINib(nibName: "\(MoreFontCells.self)", bundle: .main), forCellWithReuseIdentifier: "\(MoreFontCells.self)")
        colorSlider.addTarget(self, action: #selector(colorSliderChanging(_:)), for: .valueChanged)
        colorSlider.addTarget(self, action: #selector(colorSliderChanged(_:)), for: .touchUpInside)
        fontSizeStepper.addTarget(self, action: #selector(fontSizeXhanged(_:)), for: .valueChanged)
        fontCollectionview.delegate = self
        fontCollectionview.dataSource = self
        strokeColorSlider.addTarget(self, action: #selector(strokecolorSliderChanging(_:)), for: .valueChanged)
         strokeColorSlider.addTarget(self, action: #selector(strokecolorSliderChanged(_:)), for: .touchUpInside)
        strokeWidthStepper.addTarget(self, action: #selector(strokeWidthCanged(_:)), for: .valueChanged)
        underlineColorSlider.addTarget(self, action: #selector(underlineStyleColorChanging(_:)), for: .valueChanged)
        underlineColorSlider.addTarget(self, action: #selector(underlineStyleColorChanged(_:)), for: .touchUpInside)
        underlineStyleStepper.addTarget(self, action: #selector(underlineStyleChanged(_:)), for: .valueChanged)
        strikeThroghColorSlider.addTarget(self, action: #selector(strikeThroughcolorSliderChanged(_:)), for: .touchUpInside)
         strikeThroghColorSlider.addTarget(self, action: #selector(strikeThroughcolorSliderChanging(_:)), for: .valueChanged)
        strikeThroughStyleStepper.addTarget(self, action: #selector(strikeThroughStylehanged(_:)), for: .valueChanged)
        obliqueStepper.addTarget(self, action: #selector(obliquessChanged(_:)), for: .valueChanged)
    }
    
    
    @objc func shadowColorChanged(_ slider:ColorSlider){
        if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        shadow.shadowColor = slider.color.withAlphaComponent(model.shadowAlpha)
        model.shadowColor = slider.color
        model.shadow = shadow
        delegate?.didUpdateModel(model,true)
    }
    
    @objc func shadowColorChanging(_ slider:ColorSlider){if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        shadow.shadowColor = slider.color.withAlphaComponent(model.shadowAlpha)
        model.shadowColor = slider.color
        model.shadow = shadow
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func shadowRadiusChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        shadow.shadowBlurRadius = CGFloat(stepper.value)
        model.shadow = shadow
        delegate?.didUpdateModel(model, true)
        shadowView.shadowRadius.text = "Radius: \(Int(stepper.value))"
        
    }
    
    @objc func shadowXChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        shadow.shadowOffset.width = CGFloat(stepper.value)
        model.shadow = shadow
        delegate?.didUpdateModel(model, true)
        shadowView.shadowX.text = "X: \(Int(stepper.value))"
        
    }
    
    @objc func shadowYChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        shadow.shadowOffset.height = CGFloat(stepper.value)
        model.shadow = shadow
        delegate?.didUpdateModel(model, true)
        shadowView.shadowY.text = "Y: \(Int(stepper.value))"
    }
    
    @objc func shadowOpacityChanged(_ slider:UISlider){
        if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        model.shadowAlpha = CGFloat(slider.value)
        shadow.shadowColor = model.shadowColor.withAlphaComponent(CGFloat(slider.value))
        model.shadow = shadow
        delegate?.didUpdateModel(model, true)
    }
    
    @objc func shadowOpacityChanging(_ slider:UISlider){
        if blockDelegation{return}
        guard let shadow = model.shadow.copy() as? NSShadow else{return}
        model.shadowAlpha = CGFloat(slider.value)
        shadow.shadowColor = model.shadowColor.withAlphaComponent(CGFloat(slider.value))
        model.shadow = shadow
        delegate?.didUpdateModel(model,false)
    }
    
    
    func updatePanle(_ model:TextLayerModel){
        blockDelegation = true
        fontSizeStepper.value = Double(model.font.pointSize)
        fontSizeLable.text = "Size: \(toSignficant(x: model.font.pointSize))"
        colorSlider.color = model.textColor
        colorSlider.seekToColor(model.textColor)
        strokeLabel.text = "Stroke Width: \(model.strokeWidth)"
        strokeWidthStepper.value = Double(model.strokeWidth)
        strokeColorSlider.color = model.strokeColor ?? .white
        strokeColorSlider.seekToColor(model.strokeColor ?? .white)
        strikeStyleLabel.text = "Style: \(model.strikeThrough)"
        strikeThroughStyleStepper.value = Double(model.strikeThrough)
        strikeThroghColorSlider.color = model.strikeThroughColor ?? .white
        strikeThroghColorSlider.seekToColor(model.strikeThroughColor ?? .white)
        underlineStylelable.text = "Style: \(model.underlineStyle)"
        underlineStyleStepper.value = Double(model.underlineStyle)
        underlineColorSlider.color = model.underlineColor ?? .white
        underlineColorSlider.seekToColor(model.underlineColor ?? .white)
        
        obliqStyleLabel.text = "Style: \(model.obliquess)"
        obliqueStepper.value = Double(model.obliquess)
        shadowView.shadowOpacityslider.setValue(Float(model.shadowAlpha), animated: true)
        shadowView.colorSlider.color = model.shadowColor
        shadowView.colorSlider.seekToColor(model.shadowColor)
        shadowView.radiusStepper.value = Double(model.shadow.shadowBlurRadius)
        shadowView.Xstepper.value = Double(model.shadow.shadowOffset.width)
        shadowView.Ystepper.value = Double(model.shadow.shadowOffset.height)
        shadowView.shadowRadius.text = "\(model.shadow.shadowBlurRadius)"
        shadowView.shadowX.text = "X: \(model.shadow.shadowOffset.width)"
        shadowView.shadowY.text = "Y: \(model.shadow.shadowOffset.height)"
        shadowView.shadowRadius.text = "Radius: \(model.shadow.shadowBlurRadius)"
        shadowView.opacitylable.text = "Opacity: \(toSignficant(x: model.shadowAlpha))"
        aligmentSegment.selectedSegmentIndex = model.alignment
        
        blockDelegation = false
        self.model = model
    }
    
}
