//
//  BackingImageView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize(){
        contentMode = .scaleAspectFill
        setResizableGesture()
        clipsToBounds = true
    }

}
