//
//  TaskBarControlsProxy.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class ControlProxy:UIControl{
    
    var panelHidden = true
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
}


class ProxyImageView:UIImageView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageMaskColor(.white)
    }
}
