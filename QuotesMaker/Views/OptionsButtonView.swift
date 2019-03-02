//
//  OptionsButtonView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class OptionsButtonView: UIButton {
    
    var colors:[UIColor] = [.green,.yellow,.groupTableViewBackground,.orange,.purple,.magenta,.cyan]
    
    var option:Options!
    
    init(frame: CGRect,option:Options) {
        super.init(frame: frame)
        self.backgroundColor = colors.randomElement()!
        self.option = option
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitle(option.name, for: .normal)
        setTitleColor(.primary, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 4
    }

}
