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
    }
    
    @objc func borderWidthChanged(_ stepper:UIStepper){
        style.borderWidth = CGFloat(stepper.value)
    }
    
    @objc func cornerRadiusChanged(_ slider:UISlider){
        style.cornerRadius = CGFloat(slider.value)
    }
}
