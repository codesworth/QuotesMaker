//
//  ColorPickerView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol PickerColorDelegate:class {
    func colorDidChange(_ color:UIColor)
}

class ColorPickerView: UIView {
    
    
    private let slider = ColorSlider(orientation: .horizontal, previewView: nil)
    var currentColor:UIColor?
    weak var delegate:PickerColorDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        slider.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)
        addSubview(slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func colorChanged(_ slider:ColorSlider){
        currentColor = slider.color
        delegate?.colorDidChange(slider.color)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        slider.frame = [0,0.5 * frame.height,frame.width, 25]
        
    }

}
