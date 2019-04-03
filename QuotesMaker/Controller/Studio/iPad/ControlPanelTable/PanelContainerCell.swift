//
//  PanelContainerCell.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PanelContainerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var standardWidth = Dimensions.iPadContext.controlPanelWidth
    var panelType:ControlPanelTable.SourcePanels = .layout

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createPanels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createPanels()
    }
    
    init(type:ControlPanelTable.SourcePanels) {
        panelType = type
        super.init(style: .default, reuseIdentifier: "\(PanelContainerCell.self)")
        createPanels()
        
    }
    
    func createPanels(){
        switch panelType {
        case .fill:
            setupFillInteractiveView()
            break
        case .gradient:
            setupGradientInteractiveView()
            break
        case .img:
            setupImageInteractiveView()
            break
        case .text:
            setupTextInteractiveView()
            break
        case .layout:
            setupStyleInteractiveView()
            break
        }
    }
    
    
    func setupGradientInteractiveView(){
        let gradientPanel = GradientPanel(frame: [0,0,standardWidth,560])
        addSubview(gradientPanel)
//        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        NSLayoutConstraint.activate(gradientPanel.pinAllSides())
    }
    
    func setupFillInteractiveView(){
        let panel = ColorSliderPanel(frame: [0,0,standardWidth,250])
        addSubview(panel)
//        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupImageInteractiveView(){
        let panel = ImagePanel(frame: [0,0,standardWidth,400])
        addSubview(panel)
//        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupTextInteractiveView(){
        let panel = TextDesignableInputView(frame: [0,0,standardWidth,600], model: TextLayerModel())
        addSubview(panel)
//        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupStyleInteractiveView(){
        let panel = StylingPanel(frame: [0,0,standardWidth,600])
        addSubview(panel)
//        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        NSLayoutConstraint.activate(panel.pinAllSides())
    }
    

}
