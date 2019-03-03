//
//  DoneButton.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class DoneButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit(){
        setTitle("Done", for: .normal)
        setTitleColor(.primary, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        backgroundColor = .white
        layer.borderColor = UIColor.primary.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }

}
