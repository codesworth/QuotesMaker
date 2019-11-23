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
        colorPanel = ColorSliderPanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.colorPanelHeight])
        //colorPanel.stateDelegate = self
        gradientPanel = GradientPanel(frame: [points.x,points.y - 150, Dimensions.panelWidth,Dimensions.gradientPanelHeight])
        //gradientPanel.stateDelegate = self
        imagePanel = ImagePanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.imagePanelHeight])
        stylingPanel = StylingPanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.stylingPanelHeight])
        
        //imagePanel.stateDelegate = self
        let size = Dimensions.editorSize
        
        NSLayoutConstraint.activate([
            studioTab.topAnchor.constraint(equalTo:view.topAnchor, constant: 30),
            studioTab.heightAnchor.constraint(equalToConstant: 40),
            studioTab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            studioTab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            editorView.topAnchor.constraint(equalTo: studioTab.bottomAnchor, constant: 8),
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
}
