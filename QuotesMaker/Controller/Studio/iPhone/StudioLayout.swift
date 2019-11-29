//
//  StudioLayout.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension StudioVC{
    
    func layout(){
        view.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        let points = Dimensions.originalPanelPoints
        studioTabContainer = TabContainer(frame: [0,-200,Dimensions.panelWidth,80])
        colorPanel = ColorSliderPanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.colorPanelHeight])
        //colorPanel.stateDelegate = self
        gradientPanel = GradientPanel(frame: [points.x,points.y - 150, Dimensions.panelWidth,Dimensions.gradientPanelHeight])
        //gradientPanel.stateDelegate = self
        imagePanel = ImagePanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.imagePanelHeight])
        stylingPanel = StylingPanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.stylingPanelHeight])
        
        //imagePanel.stateDelegate = self
        let size = Dimensions.editorSize
        //tabTopConstraint = studioTab.topAnchor.constraint(equalTo:view.topAnchor, constant: -30)
//        tabTopConstraint,
//        studioTab.heightAnchor.constraint(equalToConstant: 40),
//        studioTab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//        studioTab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        NSLayoutConstraint.activate([
            
            
            editorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            editorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editorView.widthAnchor.constraint(equalToConstant: size.width),
            editorView.heightAnchor.constraint(equalToConstant: size.height),
            
            ])
        studioPanel.translatesAutoresizingMaskIntoConstraints = true
        studioPanel.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 60, width: view.frame.width, height: (UIScreen.main.bounds.height * 0.8))
//        studioPanel.layout{
//            $0.top == view.bottomAnchor - 140
//            $0.leading == view.leadingAnchor
//            $0.trailing == view.trailingAnchor
//            $0.height |=| (UIScreen.main.bounds.height * 0.8)
//        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
