//
//  ControlPanelStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class ControlPanelStackVC:UIViewController{
    
    lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
        
    }()
    
    lazy var scrollView:UIScrollView = {
        return .panelScrollView()
    }()
    
    lazy var solidPanel:ColorSliderPanel = {
        let panel = ColorSliderPanel(frame: [0,0,Dimensions.iPadContext.controlPanelWidth,Dimensions.PanelHeights.fill.rawValue])
        return panel
    }()
    
    lazy var gradientPanel:GradientPanel = {
        let panel = GradientPanel(frame: [0,0,Dimensions.iPadContext.controlPanelWidth,Dimensions.PanelHeights.gradient.rawValue])
        return panel
    }()
    
    lazy var imagePanel:ImagePanel = {
        let panel = ImagePanel(frame: [0,0,Dimensions.iPadContext.controlPanelWidth,Dimensions.PanelHeights.img.rawValue])
        return panel
    }()
    
    lazy var stylePanel:StylingPanel = {
        let panel = StylingPanel(frame: [0,0,Dimensions.iPadContext.controlPanelWidth,Dimensions.PanelHeights.layout.rawValue])
        panel.isHidden = true
        return panel
    }()
    
    lazy var textPanel:TextDesignableInputView = {
        let panel = TextDesignableInputView(frame: [0,0,Dimensions.iPadContext.controlPanelWidth,Dimensions.PanelHeights.text.rawValue], model:TextLayerModel())
        return panel
    }()
    
    var referencemodel:LayerModel?
    
    var studio:iPadStudioVC?{
        return parent as? iPadStudioVC
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var stackHeight:CGFloat{
        return Dimensions.PanelHeights.allCases.reduce(0){$0 + $1.rawValue}
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        solidPanel.delegate = studio?.coordinator
        gradientPanel.delegate = studio?.coordinator
        imagePanel.delegate = studio?.coordinator
        stylePanel.delegate = studio?.coordinator
        textPanel.delegate = studio?.coordinator
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(solidPanel)
        stackView.addArrangedSubview(gradientPanel)
        stackView.addArrangedSubview(imagePanel)
        stackView.addArrangedSubview(stylePanel)
        stackView.addArrangedSubview(textPanel)
        layout()
    }
    
   
    func layout(){
        scrollView.layout{
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.bottom == view.bottomAnchor
            $0.trailing == view.trailingAnchor
        }
        
        stackView.layout{
            $0.top == scrollView.topAnchor
            $0.leading == scrollView.leadingAnchor
            $0.bottom == scrollView.bottomAnchor
            $0.trailing == scrollView.trailingAnchor
            $0.width |=| Dimensions.iPadContext.controlPanelWidth
            $0.height |=| stackHeight
        }
        
        stackView.setNeedsLayout()
        stackView.layoutIfNeeded()
    }
    
}


extension ControlPanelStackVC{
    
    func setupGradientInteractiveView()->GradientPanel{
        let gradientPanel = GradientPanel(frame:.zero) //[0,0,standardWidth,560])
        //gradientPanel.delegate = studio?.coordinator
        
        return gradientPanel
    }
    
    func setupFillInteractiveView()->ColorSliderPanel{
        let panel = ColorSliderPanel(frame:.zero)
        if let ref = referencemodel as? ShapeModel{
            panel.update(with: ref.solid)
        }
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupImageInteractiveView()->ImagePanel{
        let panel = ImagePanel(frame: .zero)//[0,0,standardWidth,400])
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupTextInteractiveView()->TextDesignableInputView{
        let panel = TextDesignableInputView(frame:.zero,model: TextLayerModel()) //[0,0,standardWidth,600], model: TextLayerModel())
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupStyleInteractiveView()->StylingPanel{
        let panel = StylingPanel(frame:.zero) //[0,0,standardWidth,600])
        panel.header.isHidden = true
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
}
