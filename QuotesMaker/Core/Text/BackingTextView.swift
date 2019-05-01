//
//  BackingTextField.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingTextView: UIView {
    
    lazy var textView:UITextView = { [unowned self] by in
        let view = UITextView(frame: bounds, textContainer: nil)
        //view.adjustsFontForContentSizeCategory = true
        view.delegate = self
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }(())

    lazy var resizerView:SPUserResizableView = { [unowned self] by in
        let resize = SPUserResizableView(frame: bounds)
        resize.minHeight = bounds.height * 0.1
        resize.minWidth = bounds.width * 0.1
        resize.showEditingHandles()
        resize.preventsPositionOutsideSuperview = false
        resize.delegate = self
        
        return resize
    }(())
    
    enum CurrentInputType{
        case keyboard
        case designboard
    }
    
    lazy var doneToolbar: UIToolbar = {
        return UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    }()
    
    lazy var flexSpace:UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }()
    lazy var  done:UIBarButtonItem = {
        return  UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
    }()
    
    lazy var textEdits:UIBarButtonItem = {
        return UIBarButtonItem(title: "Text Effects", style: .plain, target: self, action: #selector(self.remakeInputView))
    }()
    
    var id:String{
        return "Text \(id_tag)"
    }
    var id_tag: Int = 0
    
    var currentInput:CurrentInputType = .keyboard
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        
    }
    
    var model:TextLayerModel = TextLayerModel(){
        
        didSet{
            //let state = State(model: oldValue, action: .nothing)
            //Subscription.main.post(suscription: .stateChange, object: state)
            textView.text = model.string
            textView.attributedText = model.outPutString()
            textView.textColor = model.textColor
            textView.font = model.font
            
        }
    }

    
    var uid:UUID = UUID()
    var inputFrame:CGRect = .zero
    
    
    
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
        textView.spellCheckingType = .no
        textView.autocorrectionType = .no
        textView.textColor = model.textColor
        textView.font = model.font
        backgroundColor = .clear
        textView.isScrollEnabled = true
        textView.tintColor = .black
        textView.text = "Hello"
        resizerView.contentView = textView
        addSubview(resizerView)
        
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        model.layerFrame = makeLayerFrame()
    }
    
    @objc func longTapped(_ recognizer:UILongPressGestureRecognizer){
        textView.becomeFirstResponder()
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        textlayer.bounds = bounds
//        textlayer.position = [bounds.midX,bounds.midY]
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
        doneToolbar.barStyle = .default
        
        let items = [textEdits,flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textView.inputAccessoryView = doneToolbar
        
    }
    
    @objc func remakeInputView(){
        textView.resignFirstResponder()
        defer {textView.becomeFirstResponder()}
        if currentInput == .keyboard{
            let adjustedFrame = CGRect(origin: inputFrame.origin, size: [inputFrame.size.width,320])
            model.string = textView.text
            let view = TextDesignableInputView(frame: adjustedFrame, model: self.model)
            doneToolbar.items?.first?.title = "Keyboard"
            view.delegate = self
            view.backgroundColor = .white
            self.textView.inputView = view
            
            currentInput = .designboard
        }else{
           textView.inputView = nil
            currentInput = .keyboard
            doneToolbar.items?.first?.title = "Text Effects"
        }
        
    }
    
    @objc func doneButtonAction()
    {
        self.textView.resignFirstResponder()
    }
    
//    func addTextViewAccesory(){
//        let textView = UITextView(frame: [0,0,inputFrame.width,200])
//        textView.allowsEditingTextAttributes = true
//        textView.text = model.string
//        self.textView.inputAccessoryView = textView
//    }
    
    @objc func sizeViewToFit(){
        let currentSize = bounds.size
        let newHeight = textView.text.height(withConstrainedWidth: currentSize.width, font: textView.font!)
        if newHeight != currentSize.height{
            bounds.size = [currentSize.width,newHeight]
        }
    }
    
    
}


extension BackingTextView{
    
    func watchForKeyBoardNotifications(){
        //NotificationCenter.default.addObserver(self, selector: #selector(sizeViewToFit), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(respondtoKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func deregisterNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
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
        model.string = textView.text
        self.model = model
    }
}


extension BackingTextView:BaseViewSubViewable{
    
    var layerModel: LayerModel {
        return model
    }
    
    var getIndex: CGFloat {
        return model.layerIndex
    }
    
    
    func setIndex(_ index: CGFloat) {
        model.layerIndex = index
    }
    
    
    
    func focused(_ bool: Bool) {
        if bool{
            resizerView.showEditingHandles()
        }else{
            resizerView.hideEditingHandles()
            textView.resignFirstResponder()
        }
    }
}


extension BackingTextView:SPUserResizableViewDelegate{
    
    func userResizableViewDidBeginEditing(_ userResizableView: SPUserResizableView!) {
        if textView.isFirstResponder{return}
        if let superview = superview as? BaseView, superview.selectedView != self {
            superview.selectedView = self
        }
        userResizableView.showEditingHandles()
        
    }
    
    func userResizableViewDidEndEditing(_ userResizableView: SPUserResizableView!) {
        self.frame.size = resizerView.frame.size
        //print("The new frame is: \(resizerView.frame)")
        self.frame.origin = self.frame.origin + resizerView.frame.origin
        resizerView.frame.origin = .zero
        let old = model.layerFrame
        if old == makeLayerFrame(){return}
        model.layerFrame = makeLayerFrame()
        //Subscription.main.post(suscription: .stateChange, object: State(model: model, action: .nothing))
    }
}


extension BackingTextView:UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if let superview = superview as? BaseView, superview.selectedView != self {
            superview.selectedView = self
        }
        resizerView.showEditingHandles()
        return true
    }
    
}

extension BackingTextView:NSCopying{
    func copy(with zone: NSZone? = nil) -> Any {
        let text = BackingTextView(frame: frame)
        text.model = model
        return text
    }
    

}

//Font Type
//Font size
//Font Color
//Stroke Width
// underline
//strikethrough

