//
//  CornersPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

final class CornersPanel:UIView{
    
    lazy var cornerlable:BasicLabel = {
        return .basicLabel("Corners")
    }()
    
    lazy var cornerRadius:BasicLabel = {
        return .basicLabel("Radius")
    }()
    
    lazy var slider:UISlider = {
        let slider = UISlider(frame: .zero)
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.tintColor = .primary
        return slider
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func initialize(){
        
        addSubview(<#T##view: UIView##UIView#>)
    }
}
