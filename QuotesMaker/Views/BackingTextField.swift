//
//  BackingTextField.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingTextField: UITextView {

    init(frame: CGRect) {
        super.init(frame: frame,textContainer:nil)
        initialize()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    lazy var textlayer:TextBackingLayer = {
        let layer = TextBackingLayer()
        layer.bounds = bounds
        return layer
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize(){
        //layer.addSublayer(textlayer)
        textColor = UIColor.black
        font = textlayer.model.font
        backgroundColor = .clear
    
        isScrollEnabled = false
        tintColor = .black
        text = "Hello"
        textAlignment = .center
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textlayer.bounds = bounds
        textlayer.position = [bounds.midX,bounds.midY]
        //textlayer.backgroundColor = UIColor.green.cgColor
    }
}

extension BackingTextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
