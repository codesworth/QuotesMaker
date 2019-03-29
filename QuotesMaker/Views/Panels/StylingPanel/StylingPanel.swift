//
//  StylingPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


protocol StylingDelegate:class {
    
    func didFinishStyling(_ style:Style)
}

class StylingPanel:MaterialView{
    
    lazy var stateControl:StateChangeControl = {
        let view = StateChangeControl(frame: .zero)
        view.undoButt.addTarget(self, action: #selector(undo), for: .touchUpInside)
        view.redoButt.addTarget(self, action: #selector(redo), for: .touchUpInside)
        return view
    }()
    
    lazy var closeButton:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    var style:Style = Style()
    
    lazy var scrollView: UIScrollView = {
        return .panelScrollView()
    }()
    
    lazy var contentView:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    lazy var header:BasicLabel = {
        let lab = BasicLabel.basicHeader()
        lab.text = "Styling"
        lab.textColor = .primary
        return lab
    }()
    
    lazy var cornerPanel: CornersPanel = {
        
        let panel = CornersPanel(frame: .zero)
        panel.slider.addTarget(self, action: #selector(cornerRadiusChanged(_:)), for: .valueChanged)
        
        return panel
    }()
    
    lazy var borderPanel: BorderPanel = {
        
        let panel = BorderPanel(frame: .zero)
        panel.widthStepper.addTarget(self, action: #selector(borderWidthChanged(_:)), for: .valueChanged)
        panel.colorSlider.addTarget(self, action: #selector(borderColorChanged(_:)), for: .valueChanged)
        return panel
    }()
    
    lazy var shadowsPanel:ShadowPanel = {
        let selectors:ShadowPanel.Selectors =
        (#selector(shadowColorChanged(_:)),
         #selector(shadowRadiusChanged(_:)),
         #selector(shadowXChanged(_:)),
         #selector(shadowYChanged(_:)),
         #selector(shadowOpacityChanged(_:)),
         #selector(shadowColorChanging(_:)),
         #selector(shadowOpacityChanging(_:)))
        let panel = ShadowPanel(frame: .zero)
        panel.setTargets(object: self, selectors: selectors)
        return panel
    }()
    

    
    lazy var firstline:LineView = {
        return .getShadowedline()
    }()
    
    lazy var secondline:LineView = {
        return .getShadowedline()
    }()
    
    lazy var thirdline:LineView = {
        return .getShadowedline()
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    weak var delegate:StylingDelegate?
    weak var stateDelegate:StateControlDelegate?
    
    func initialize(){
        backgroundColor = .white
        addSubview(header)
        addSubview(stateControl)
        addSubview(closeButton)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        contentView.addSubview(shadowsPanel)
        contentView.addSubview(thirdline)
        contentView.addSubview(cornerPanel)
        contentView.addSubview(borderPanel)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        header.layout{
            $0.top == topAnchor + 8
            $0.leading == leadingAnchor + 20
        }
        
        closeButton.layout{
            $0.top == topAnchor + 8
            $0.trailing == trailingAnchor - 20
            $0.height |=| 35
            $0.width |=| 35
        }
        
        stateControl.layout{
            $0.top == topAnchor + 8
            $0.trailing == closeButton.leadingAnchor - 16
            $0.height |=| 30
            $0.width |=| 70
        }
        
        scrollView.layout{
            $0.top == closeButton.bottomAnchor + 12
            $0.leading == leadingAnchor
            $0.bottom == bottomAnchor
            $0.trailing == trailingAnchor
        }
        
        contentView.layout{
            $0.top == scrollView.topAnchor
            $0.leading == scrollView.leadingAnchor
            $0.bottom == scrollView.bottomAnchor
            $0.trailing == scrollView.trailingAnchor
            $0.width == widthAnchor
            $0.height |=| 500
        }
        
        
        firstline.layout{
            $0.top == contentView.topAnchor + 4
            $0.leading == contentView.leadingAnchor //+ 20
            $0.trailing == contentView.trailingAnchor //- 20
            $0.height |=| 0.5
        }
        
        cornerPanel.layout{
            $0.top == firstline.bottomAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.height |=| 60
        }
        
        secondline.layout{
            $0.top == cornerPanel.bottomAnchor + 30
            $0.leading == contentView.leadingAnchor - 20
            $0.trailing == contentView.trailingAnchor +  20
            $0.height |=| 0.5
        }
        
        borderPanel.layout{
            $0.top == secondline.bottomAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.height |=| 100
        }
        
        thirdline.layout{
            $0.top == borderPanel.bottomAnchor + 30
            $0.leading == contentView.leadingAnchor - 20
            $0.trailing == contentView.trailingAnchor +  20
            $0.height |=| 0.5
        }
        
        shadowsPanel.layout{
            $0.top == thirdline.bottomAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.height |=| 300
        }
    }
}


extension StylingPanel{
    
    @objc func donePressed(){
        Utils.animatePanelsOut(self)
        unsubscribe()
    }
    
    
    @objc func undo(){
        stateDelegate?.stateChanged(.undo)
    }
    
    @objc func redo(){
        stateDelegate?.stateChanged(.redo)
    }
}
