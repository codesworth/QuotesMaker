//
//  OptionsButtonView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class OptionsButtonView: UIButton {
    
    var option:Options!
    
    init(frame: CGRect,option:Options) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.option = option
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
