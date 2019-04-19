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
        if blockDelegation{return}
        style.borderColor = slider.color
        delegate?.didFinishStyling(style)
    }
    
    @objc func borderWidthChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        style.borderWidth = CGFloat(stepper.value)
        borderPanel.borderWidth.text = "Width: \(stepper.value)"
        delegate?.didFinishStyling(style)
        
    }
    
    @objc func cornerRadiusChanged(_ slider:UISlider){
        if blockDelegation{return}
        style.cornerRadius = CGFloat(slider.value)
        cornerPanel.cornerlable.text = "Radius: \(Int(slider.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func cornerRadiusChanging(_ slider:UISlider){
        if blockDelegation{return}
        style.cornerRadius = CGFloat(slider.value)
        cornerPanel.cornerlable.text = "Radius: \(Int(slider.value))"
        delegate?.didFinishPreviewing(style)
    }
    
    @objc func shadowColorChanged(_ slider:ColorSlider){
        if blockDelegation{return}
        style.shadowColor = slider.color
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowColorChanging(_ slider:ColorSlider){
        if blockDelegation{return}
        style.shadowColor = slider.color
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowRadiusChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        style.shadowRadius = CGFloat(stepper.value)
        shadowsPanel.shadowRadius.text = "Radius: \(stepper.value.rounded())"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowXChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        style.shadowOffset.width = CGFloat(stepper.value)
        shadowsPanel.shadowX.text = "X: \(toSignficant(x: stepper.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowYChanged(_ stepper:UIStepper){
        if blockDelegation{return}
        style.shadowOffset.height = CGFloat(stepper.value)
        shadowsPanel.shadowY.text = "Y: \(toSignficant(x: stepper.value))"
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowOpacityChanged(_ slider:UISlider){
        if blockDelegation{return}
        style.shadowOpacity = slider.value
        delegate?.didFinishStyling(style)
    }
    
    @objc func shadowOpacityChanging(_ slider:UISlider){
        if blockDelegation{return}
        style.shadowOpacity = slider.value
        delegate?.didFinishPreviewing(style)
    }
    
    
    @objc func listenForCornermaskChanges(_ notification:Notification){
        if blockDelegation{return}
        if let corners = notification.userInfo?[.info] as? CACornerMask{
            style.maskedCorners = corners
            delegate?.didFinishStyling(style)
        }
    }
    
    func updatePanel(_ style:Style,size:CGSize){
        blockDelegation = true
        cornerPanel.slider.setValue(Float(style.cornerRadius), animated: true)
        cornerPanel.slider.maximumValue = Float(size.min)
        cornerPanel.cornerlable.text = "Radius: \(style.cornerRadius)"
        if let corners = style.maskedCorners{
            cornerPanel.roundCornerView.layoutCorners(corner:corners)
        }
        borderPanel.colorSlider.color = style.borderColor
        borderPanel.colorSlider.seekToColor(style.borderColor)
        borderPanel.borderWidth.text = "Width: \(style.borderWidth)"
        borderPanel.widthStepper.value = Double(style.borderWidth)
        shadowsPanel.colorSlider.color = style.shadowColor
        shadowsPanel.colorSlider.seekToColor(style.shadowColor)
        shadowsPanel.radiusStepper.value = Double(style.shadowRadius)
        shadowsPanel.shadowRadius.text = "Radius: \(style.shadowRadius)"
        shadowsPanel.Xstepper.value = Double(style.shadowOffset.width)
        shadowsPanel.shadowX.text = "X: \(toSignficant(x: style.shadowOffset.width))"
        shadowsPanel.Ystepper.value = Double(style.shadowOffset.height)
        shadowsPanel.shadowY.text = "Y: \(toSignficant(x: style.shadowOffset.height))"
        shadowsPanel.shadowOpacityslider.setValue(style.shadowOpacity, animated: true)
        
        self.style = style
        blockDelegation = false
        
    }
    
}
