//
//  File.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 18/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



extension GradientPanel{
    
    func updatepanel(_ model:GradientLayerModel){
        blockDelegation = true
        gradientSegments.removeAllSegments()
        for (index,_) in model.gradientColors().enumerated(){
            gradientSegments.insertSegment(withTitle: "\(index + 1)", at: index, animated: true)
        }
        gradientSegments.selectedSegmentIndex = 0
        colorSlider.color = model.getRawColorAt(0)
        colorSlider.seekToColor(model.getRawColorAt(0))
        alphaSlider.slider.setValue(Float(model.alphas.first!), animated: true)
        locationSlider.setValue(model.locations.first!.floatValue, animated: true)
        controlPadView.pad.setControlTo(model.startPoint)
        self.model = model
        blockDelegation = false
        //stepperTitle.text = "\()"
    }
}
