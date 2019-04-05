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
        stylingPanel = StylingPanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.imagePanelHeight])
        
        //imagePanel.stateDelegate = self
        let size = Dimensions.editorSize
        
        NSLayoutConstraint.activate([
            studioTab.topAnchor.constraint(equalTo:view.topAnchor, constant: 40),
            studioTab.heightAnchor.constraint(equalToConstant: 40),
            studioTab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            studioTab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            studioTab.heightAnchor.constraint(equalToConstant: 40),
            editorView.topAnchor.constraint(equalTo: studioTab.bottomAnchor, constant: 20),
            editorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editorView.widthAnchor.constraint(equalToConstant: size.width),
            editorView.heightAnchor.constraint(equalToConstant: size.height),
            
            ])
        studioPanel.layout{
            $0.bottom == view.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| studioHeight
        }
        
    }
}
