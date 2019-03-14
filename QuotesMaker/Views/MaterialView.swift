//
//  MaterialFeel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        materialFeel()
    }
    
    var isInView:Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        materialFeel()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        isInView = false
    }
    
    func setCorner(_ radius:CGFloat){
        layer.cornerRadius = radius
    }
    
    func materialFeel(){
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = 2
    }

}
