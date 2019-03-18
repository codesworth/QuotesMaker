//
//  Cropview.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 18/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class Cropview: UIView {
    
    lazy var topLine:LineView = {
        let line = LineView(frame: .zero)
        line.backgroundColor = .white
        return line
    }()
    
    var startingLocation:CGPoint?
    
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
    
    func initialize(){
        //borderlize(.white, 3)
        addSubview(topLine)
        backgroundColor = .magenta
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLine.frame = [0,0,bounds.width,10]
        
    }
    
}
