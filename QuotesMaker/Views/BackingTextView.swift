//
//  BackingTextField.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingTextView: UITextView {

    enum CurrentInputType{
        case keyboard
        case designboard
    }
    
    var id:String{
        return "Text \(id_tag)"
    }
    var id_tag: Int = 0
    
    var currentInput:CurrentInputType = .keyboard
    
    init(frame: CGRect) {
        super.init(frame: frame,textContainer:nil)
        initialize()
        
    }
    
    var model:TextLayerModel = TextLayerModel(){
        
        didSet{
            attributedText = model.outPutString()
            textColor = model.textColor
            font = model.font
            model.string = text
        }
    }
    
    override var attributedText: NSAttributedString!{
        didSet{
            print("I was updated \(String(describing: text))")
        }
    }
    
    
    
    var inputFrame:CGRect = .zero
    
    
    
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
        clipsToBounds = false
        spellCheckingType = .no
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 0.5
        setPanGesture()
        setResizableGesture()
        //movedInFocus()
        textColor = model.textColor
        font = model.font
        backgroundColor = .clear
        isScrollEnabled = true
        tintColor = .black
        text = "Hello"
        
        //textAlignment = .center
        
    
    }
    
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textlayer.bounds = bounds
        textlayer.position = [bounds.midX,bounds.midY]
        watchForKeyBoardNotifications()
        //textlayer.backgroundColor = UIColor.green.cgColor
    }
    
    deinit {
        deregisterNotification()
    }
}

extension BackingTextView{
    
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
        let fonts: UIBarButtonItem = UIBarButtonItem(title: "Edits", style: .plain, target: self, action: #selector(self.remakeInputView))
        let items = [fonts,flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
    }
    
    @objc func remakeInputView(){
        resignFirstResponder()
        defer {becomeFirstResponder()}
        if currentInput == .keyboard{
            let adjustedFrame = CGRect(origin: inputFrame.origin, size: [inputFrame.size.width,320])
            model.string = text
            let view = TextDesignableInputView(frame: adjustedFrame, model: self.model)
            
            view.delegate = self
            view.backgroundColor = .white
            self.inputView = view
            
            currentInput = .designboard
        }else{
           inputView = nil
            currentInput = .keyboard
        }
        
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    
}


extension BackingTextView{
    
    func watchForKeyBoardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(respondtoKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func deregisterNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func respondtoKeyBoard(_ notification: Notification){
        //Calculate lenght to bottom of screen
        
        let keyBoardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.inputFrame = keyBoardFrame
    }
}




extension BackingTextView:TextModelDelegate{
    
    func didUpdateModel(_ model: TextLayerModel) {
        var model = model
        model.string = text
        self.model = model
    }
}
//Font Type
//Font size
//Font Color
//Stroke Width
// underline
//strikethrough

