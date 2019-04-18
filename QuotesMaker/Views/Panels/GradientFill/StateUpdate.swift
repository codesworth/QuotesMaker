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
        gradientSegments.removeAllSegments()
        for (index,_) in model.colors.enumerated(){
            gradientSegments.insertSegment(withTitle: "\(index + 1)", at: index, animated: true)
        }
        colorSlider.color = UIColor(cgColor: model.colors.first!)
        colorSlider.seekToColor(UIColor(cgColor: model.colors.first!))
        alphaSlider.slider.setValue(model.alph, animated: <#T##Bool#>)
    }
}
