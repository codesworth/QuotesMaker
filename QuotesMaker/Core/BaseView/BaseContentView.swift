//
//  File.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 21/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



final class BaseContentView:UIView{
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func initialize(){
        backgroundColor = .clear
        clipsToBounds = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Yayyyy touches began")
        //scrollValue = true
    }
    
}


