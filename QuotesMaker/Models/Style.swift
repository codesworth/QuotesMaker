//
//  Style.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct Style {
    
    var cornerRadius:CGFloat = 0
    var maskedCorners:CACornerMask? = nil
    var borderColor:UIColor = .clear
    var borderWidth:CGFloat = 0
    
    //Shadows
    var shadowColor:UIColor = .clear
    var shadowOpacity:CGFloat = 0
    var shadowRadius:CGFloat = 0
    var shadowOffset:CGSize = .zero
    
    
}
