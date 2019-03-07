//
//  Selectors.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension TextDesignableInputView{
    
    @objc func colorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.textColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func fontSizeXhanged(_ stepper:UIStepper){
        let val = stepper.value
        fontSizeLable.text =  "Size: \(val)"
        let newFont = UIFont(name: chosenFont, size: CGFloat(val))!
        model.font = newFont
        delegate?.didUpdateModel(model)
    }
    
    @objc func strokecolorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.strokeColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func strokeWidthCanged(_ stepper:UIStepper){
        let val = stepper.value
        fontSizeLable.text =  "Size: \(val)"
        model.strokeWidth = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    @objc func underlineStyleColorChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.underlineColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func underlineStyleChanged(_ stepper:UIStepper){
        let val = stepper.value
        
        model.underlineStyle = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    @objc func strikeThroughcolorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.strikeThroughColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func strikeThroughStylehanged(_ stepper:UIStepper){
        let val = stepper.value
        model.strikeThrough = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    @objc func obliquessChanged(_ stepper:UIStepper){
        let val = stepper.value
        model.obliquess = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    func registrationsAndtargetSets(){
        fontCollectionview.register(UINib(nibName: "\(FontCells.self)", bundle: nil), forCellWithReuseIdentifier: "\(FontCells.self)")
        colorSlider.addTarget(self, action: #selector(colorSliderChanged(_:)), for: .valueChanged)
        fontSizeStepper.addTarget(self, action: #selector(fontSizeXhanged(_:)), for: .valueChanged)
        fontCollectionview.delegate = self
        fontCollectionview.dataSource = self
        strokeColorSlider.addTarget(self, action: #selector(strokecolorSliderChanged(_:)), for: .valueChanged)
        strokeWidthStepper.addTarget(self, action: #selector(strokeWidthCanged(_:)), for: .valueChanged)
        underlineColorSlider.addTarget(self, action: #selector(underlineStyleColorChanged(_:)), for: .valueChanged)
        underlineStyleStepper.addTarget(self, action: #selector(underlineStyleChanged(_:)), for: .valueChanged)
        strikeThroghColorSlider.addTarget(self, action: #selector(strikeThroughcolorSliderChanged(_:)), for: .valueChanged)
        strikeThroughStyleStepper.addTarget(self, action: #selector(strikeThroughStylehanged(_:)), for: .valueChanged)
        obliqueStepper.addTarget(self, action: #selector(obliquessChanged(_:)), for: .valueChanged)
    }
    
    
}
