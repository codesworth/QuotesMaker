//
//  OptionsStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class OptionsStack: UIView {
    
    
    private var stackView:UIStackView
    private var upperStack:UIStackView
    private var lowerStack:UIStackView
    
    
    override init(frame: CGRect) {
        stackView = UIStackView(frame: frame)
        upperStack = UIStackView(frame: .zero)
        lowerStack = UIStackView(frame: .zero)
        upperStack.axis = .horizontal
        lowerStack.axis = .horizontal
        upperStack.distribution = .fillEqually
        lowerStack.distribution = .fillEqually
        lowerStack.spacing = 2
        upperStack.spacing = 2
        lowerStack.alignment = .fill
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        
    }

}
