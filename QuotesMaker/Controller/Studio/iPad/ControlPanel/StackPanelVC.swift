//
//  StackPanelVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StackPanelVC: UIViewController {
    
    enum TypeHeights:CGFloat{
         case shape = 1600
        case image = 1000
        case text = 1308
    }
    @IBOutlet weak var canvaspanelStack: UIStackView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textInputStack: UIStackView!
    @IBOutlet weak var canvasBackgoundColorPanel: ColorSliderPanel!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var fillStack: UIStackView!
    @IBOutlet weak var gradientStack: UIStackView!
    @IBOutlet weak var imagetack: UIStackView!
    @IBOutlet weak var styleStack: UIStackView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var textStack: UIStackView!
    @IBOutlet weak var fillControl: ControlProxy!
    @IBOutlet weak var gradientcontrol: ControlProxy!
    @IBOutlet weak var imagecontrol: ControlProxy!
    @IBOutlet weak var stylecontrol: ControlProxy!
    @IBOutlet weak var textcontrol: ControlProxy!
    @IBOutlet weak var fillPanel:ColorSliderPanel!
    @IBOutlet weak var gradientPanel:GradientPanel!
    @IBOutlet weak var imagePanel:ImagePanel!
    @IBOutlet weak var stylePanel:StylingPanel!
    @IBOutlet weak var textPanel:TextDesignableInputView!
    var viewSize:CGSize = [200]
    @IBOutlet weak var parentStack: UIStackView!
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        canvaspanelStack.isHidden = true
        gradientPanel.scrollView.isScrollEnabled = false
        imagePanel.scrollView.isScrollEnabled = false
        stylePanel.scrollView.isScrollEnabled = false
        textPanel.scrollView.isScrollEnabled = false
        textInputStack.isHidden = true
        fillControl.roundCorners(5)
        
        gradientcontrol.roundCorners(5)
        imagecontrol.roundCorners(5)
        stylecontrol.roundCorners(5)
        textcontrol.roundCorners(5)
        parentStack.isHidden = true
        canvasBackgoundColorPanel.delegate = self
        fillPanel.delegate = studio.coordinator
        fillPanel.doneButt.isHidden = true
        fillPanel.roundCorners(5)
        gradientPanel.roundCorners(5)
        stylePanel.roundCorners(5)
        gradientPanel.delegate = studio.coordinator
        imagePanel.delegate = studio.coordinator
        stylePanel.delegate = studio.coordinator
        textPanel.delegate = studio.coordinator
        textView.delegate = self
        subscribeTo(subscription: .roundedCornerRadiusValueChanged, selector: #selector(changeCornerRadius(_ :)))
//        fillStack.isHidden = true
//        fillPanel.isHidden = fillControl.panelHidden
//        gradientPanel.isHidden = gradientcontrol.panelHidden
//        gradientStack.isHidden = true
//        imagetack.isHidden = true
//        imagePanel.isHidden = imagecontrol.panelHidden
//        styleStack.isHidden = true
//        stylePanel.isHidden = stylecontrol.panelHidden
//        textStack.isHidden = true
//        textPanel.isHidden = textcontrol.panelHidden
        subscribeTo(subscription: .activatedLayer, selector: #selector(layerChanged(_:)))
        // Do any additional setup after loading the view.
    }
    
   
    
    
    private var studio:iPadStudioVC{
        return parent as! iPadStudioVC
    }
    
    @objc func changeCornerRadius(_ notification:Notification){
//        if let value = notification.userInfo?[.info] as? CGFloat{
//            stylePanel.cornerPanel.slider.maximumValue = Float(value)
//            
//        }
    }
    
    
    @objc func layerChanged(_ notification:Notification){
        if let view = notification.userInfo?[.info] as? BaseView.BaseSubView{
            canvaspanelStack.isHidden = true
            viewSize = view.bounds.size
            if type(of: view) == RectView.self{
                panelForCurrent(.shape, model: view.layerModel)
            }
            if type(of: view) == BackingImageView.self{
                panelForCurrent(.img, model: view.layerModel)
            }
            if type(of: view) == BackingTextView.self{
                panelForCurrent(.text, model: view.layerModel)
            }
        }
//        }else{
//            canvaspanelStack.isHidden = false
//            textInputStack.isHidden = true
//            imagetack.isHidden = true
//            textStack.isHidden = true
//            parentStack.isHidden = true
//            fillStack.isHidden = true
//            gradientStack.isHidden = true
//            styleStack.isHidden = true
//        }
    }
    
    
    func panelForCurrent(_ type:ViewType, model:LayerModel){
        
        switch type {
        case .shape:
            containerHeight.constant = TypeHeights.shape.rawValue
            stackHeight.constant = TypeHeights.shape.rawValue
            switchToShape(model)
            break
        case .img:
            containerHeight.constant = TypeHeights.image.rawValue
            stackHeight.constant = TypeHeights.image.rawValue
            switchToImage(model)
            break
        case .text:
            containerHeight.constant = TypeHeights.text.rawValue
            stackHeight.constant = TypeHeights.text.rawValue
            switchToText(model)
            break
        }
        parentStack.distribution = .fillProportionally
    }
    
    func switchToShape(_ model:LayerModel){
        guard let model = model as? ShapeModel else {return}
        //Set Solid, Gradient && Style
        //First hide all unwanted
        textInputStack.isHidden = true
        imagetack.isHidden = true
        textStack.isHidden = true
        parentStack.isHidden = false
        fillStack.isHidden = false
        gradientStack.isHidden = false
        styleStack.isHidden = false
        fillPanel.update(with: model.solid)
        if let gradient = model.gradient{
            gradientPanel.updatepanel(gradient)
        }
        stylePanel.updatePanel(model.style, size: viewSize)
        
    }
    
    func switchToImage(_ model:LayerModel){
        guard let model = model as? ImageLayerModel else {return}
        //Set Solid, Gradient && Style
        //First hide all unwanted
        textInputStack.isHidden = true
        textStack.isHidden = true
        parentStack.isHidden = false
        fillStack.isHidden = true
        gradientStack.isHidden = true
        imagetack.isHidden = false
        styleStack.isHidden = false
        stylePanel.updatePanel(model.style, size: viewSize)
        
    }
    
    func switchToText(_ model:LayerModel){
        guard let model = model as? TextLayerModel else {return}
        //Set Solid, Gradient && Style
        //First hide all unwanted
        parentStack.isHidden = true
        textStack.isHidden = false
        textInputStack.isHidden = false
        textView.text = model.string
        textPanel.updatePanle(model)
        
        
    }
    
    
    @IBAction func fillTapped(_ sender: ControlProxy) {
//        fillControl.panelHidden = !fillControl.panelHidden
       // fillPanel.isHidden = fillControl.panelHidden
    }
    
    @IBAction func gradientTapped(_ sender: ControlProxy) {
//        gradientcontrol.panelHidden = !gradientcontrol.panelHidden
//        gradientPanel.isHidden = gradientcontrol.panelHidden
    }
    
    
    
    @IBAction func imageTapped(_ sender: ControlProxy) {
//        imagecontrol.panelHidden = !imagecontrol.panelHidden
//        imagePanel.isHidden = imagecontrol.panelHidden
    }
    
    @IBAction func styleTapped(_ sender: ControlProxy) {
//        stylecontrol.panelHidden = !stylecontrol.panelHidden
//        stylePanel.isHidden = stylecontrol.panelHidden
    }
    
    @IBAction func textTapped(_ sender: ControlProxy) {
//        textcontrol.panelHidden = !textcontrol.panelHidden
//        textPanel.isHidden = textcontrol.panelHidden
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension StackPanelVC:PickerColorDelegate{
    func colorDidChange(_ model: BlankLayerModel) {
        //
        studio.coordinator.baseView.backgroundColor = model.color
    }
    
    func previewingWith(_ model: BlankLayerModel) {
        //
        studio.coordinator.baseView.backgroundColor = model.color
    }
    
    
    
}






extension StackPanelVC:UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text!
        studio.coordinator.textChanged(text:text)
    }
}
