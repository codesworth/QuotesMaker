//
//  BasicLabel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BasicLabel: UILabel {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        simpleSetup()
    }
    
    init(frame: CGRect, font:UIFont) {
        super.init(frame: frame)
        simpleSetup()
        self.font = font
    }
    
    func simpleSetup(){
        font = .systemFont(ofSize: 16, weight: .medium)
        textColor = .black
        textAlignment = .center
        numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        simpleSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func basicMake()->BasicLabel{
        return BasicLabel(frame: .zero, font: .systemFont(ofSize: 15, weight: .regular))
    }
    
    class func basicLabel(_ text:String,_ color:UIColor = .white)->BasicLabel{
        let label = BasicLabel(frame: .zero, font: .systemFont(ofSize: 14, weight: .thin))
        label.text = text
        label.textAlignment = .center
        label.textColor = color
        return label
    }
    
    class func basicHeader()->BasicLabel{
        return BasicLabel(frame: .zero, font: .systemFont(ofSize: 18, weight: .semibold))
    }
    
}
