//
//  Selectors.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension StylingPanel{
    
    @objc func borderColorChanged(_ slider:ColorSlider){
        style.borderColor = slider.color
        delegate?.didFinishStyling(style)
    }
    
    @objc func borderWidthChanged(_ stepper:UIStepper){
        style.borderWidth = CGFloat(stepper.value)
        borderPanel.borderWidth.text = "Width: \(stepper.value)"
        delegate?.didFinishStyling(style)
        
    }
    
    @objc func cornerRadiusChanged(_ slider:UISlider){
        style.cornerRadius = CGFloat(slider.value)
        cornerPanel.cornerlable.text = "Radius: \(Int(slider.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowColorChanged(_ slider:ColorSlider){
        style.shadowColor = slider.color
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowColorChanging(_ slider:ColorSlider){
        style.shadowColor = slider.color
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowRadiusChanged(_ stepper:UIStepper){
        style.shadowRadius = CGFloat(stepper.value)
        shadowsPanel.shadowRadius.text = "Radius: \(Int(stepper.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowXChanged(_ stepper:UIStepper){
        style.shadowOffset.width = CGFloat(stepper.value)
        shadowsPanel.shadowX.text = "X: \(Int(stepper.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowYChanged(_ stepper:UIStepper){
        style.shadowOffset.height = CGFloat(stepper.value)
        shadowsPanel.shadowY.text = "Y: \(Int(stepper.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowOpacityChanged(_ slider:UISlider){
        style.shadowOpacity = slider.value
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowOpacityChanging(_ slider:UISlider){
        style.shadowOpacity = slider.value
        delegate?.didFinishStyling(style)
    }
    
    
    @objc func listenForCornermaskChanges(_ notification:Notification){
        if let corners = notification.userInfo?[.info] as? CACornerMask{
            style.maskedCorners = corners
            delegate?.didFinishStyling(style)
        }
    }
    
}
