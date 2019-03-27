//
//  StylingPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


protocol StylingDelegate:class {
    
}

class StylingPanel:MaterialView{
    
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
    
    @objc func borderColorChanged(_ slider:ColorSlider){
        
    }
    
    @objc func borderWidthChanged(_ stepper:UIStepper){
        
    }
    
    @objc func cornerRadiusChanged(_ slider:UISlider){
        
    }
    
    lazy var firstline:LineView = {
        return .getLine()
    }()
    
    lazy var secondline:LineView = {
        return .getLine()
    }()
    
    lazy var thirdline:LineView = {
        return .getLine()
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
    
    func initialize(){
        backgroundColor = .white
        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        contentView.addSubview(thirdline)
        contentView.addSubview(cornerPanel)
        contentView.addSubview(borderPanel)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        header.layout{
            $0.top == topAnchor + 8
            $0.centerX == centerXAnchor
        }
        
        scrollView.layout{
            $0.top == header.bottomAnchor + 4
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
            $0.height |=| 350
        }
        
        
        firstline.layout{
            $0.top == contentView.topAnchor + 4
            $0.leading == contentView.leadingAnchor + 20
            $0.trailing == contentView.trailingAnchor - 20
            $0.height |=| 1
        }
        
        cornerPanel.layout{
            $0.top == firstline.bottomAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.height |=| 60
        }
        
        secondline.layout{
            $0.top == cornerPanel.bottomAnchor + 4
            $0.leading == contentView.leadingAnchor + 20
            $0.trailing == contentView.trailingAnchor - 20
            $0.height |=| 1
        }
        
        borderPanel.layout{
            $0.top == secondline.bottomAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.height |=| 100
        }
    }
}
