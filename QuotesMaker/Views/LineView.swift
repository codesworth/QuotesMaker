//
//  LineView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class LineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        regularInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        regularInit()
    }
    
    func regularInit(){
        backgroundColor = .black
        layer.cornerRadius = 3
    }
    
    class func getLine()->LineView{
        return LineView(frame: .zero)
    }
    
}
