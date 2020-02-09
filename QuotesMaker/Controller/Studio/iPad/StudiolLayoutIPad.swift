//
//  StudiolLayoutIPad.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension iPadStudioVC{
    
    func iPadLayout(){
        //print(view.constraints)
        view.removeConstraints(view.constraints)
        let orientation = UIScreen.orientation
        let handle = UIScreen.main.screenType()
        switch orientation {
        case .landscape:
            if handle == .pad_norm || handle == .pad_pro_9_7{
                iPadSmallLayoutLandscape()
                return
            }else{
                iPadlargeLayoutLandscape()
                return
            }
        case .potrait:
            if handle == .pad_norm || handle == .pad_pro_9_7{
               iPadSmallLayoutLandscape()
                //iPadLayoutLargePotrait()
                return
            }else{
                iPadlargeLayoutLandscape()
                return
            }
            
        }
        //iPadlargeLayoutLandscape()
    
    }
    
    func iPadSmallLayoutLandscape(){
        taskbarContainer.layout{
            $0.top == view.topAnchor + 30
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 100
        }
        
        taskbar.view.layout{
            $0.top == taskbarContainer.topAnchor
            $0.bottom == taskbarContainer.bottomAnchor
            $0.trailing == taskbarContainer.trailingAnchor
            $0.leading == taskbarContainer.leadingAnchor
        }
        taskbar.setContentWidth()
        
        controlPanelContainer.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
            $0.width |=| (Dimensions.iPadContext.controlPanelWidth + 50)
            
        }
        
        panelController.view.layout{
            $0.top == controlPanelContainer.topAnchor
            $0.trailing == controlPanelContainer.trailingAnchor
            $0.bottom == controlPanelContainer.bottomAnchor
            $0.width |=| (Dimensions.iPadContext.controlPanelWidth + 50)
        }
        
        layerStack.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.leading == view.leadingAnchor -- layerStack.constraintIds.leading
            $0.bottom == view.bottomAnchor
            $0.width |=| Dimensions.iPadContext.layerStackWidth
        }
        
        editor.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.leading == layerStack.trailingAnchor
            $0.trailing == controlPanelContainer.leadingAnchor
            $0.bottom == view.bottomAnchor - 2
        }
        
    }
    
    func iPadlargeLayoutLandscape(){
        taskbarContainer.layout{
            $0.top == view.topAnchor + 30
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 100
        }
        
        taskbar.view.layout{
            $0.top == taskbarContainer.topAnchor
            $0.bottom == taskbarContainer.bottomAnchor
            $0.trailing == taskbarContainer.trailingAnchor
            $0.leading == taskbarContainer.leadingAnchor
        }
        taskbar.setContentWidth()
        
        controlPanelContainer.layout(true){
            $0.top == taskbarContainer.bottomAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
            $0.width |=| Dimensions.iPadContext.controlPanelWidth
        }
        
        panelController.view.layout{
            $0.top == controlPanelContainer.topAnchor
            $0.trailing == controlPanelContainer.trailingAnchor
            $0.bottom == controlPanelContainer.bottomAnchor
            $0.width |=| Dimensions.iPadContext.controlPanelWidth
        }
        
        layerStack.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.leading == view.leadingAnchor -- layerStack.constraintIds.leading
            $0.bottom == view.bottomAnchor
            $0.width |=| Dimensions.iPadContext.layerStackWidth
        }
        
        editor.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.leading == layerStack.trailingAnchor
            $0.trailing == controlPanelContainer.leadingAnchor
            $0.bottom == view.bottomAnchor - 2
        }
    }
    
    
    func iPadLayoutLargePotrait(){
        let remHeight = (view.frame.height * 0.40) - 120
        taskbarContainer.layout{
            $0.top == view.topAnchor + 30
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 100
        }
        
        taskbar.view.layout{
            $0.top == taskbarContainer.topAnchor
            $0.bottom == taskbarContainer.bottomAnchor
            $0.trailing == taskbarContainer.trailingAnchor
            $0.leading == taskbarContainer.leadingAnchor
        }
        taskbar.setContentWidth()
        
        editor.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor//controlPanelContainer.leadingAnchor - 2
            //$0.bottom == //layerStack.topAnchor - 2
            $0.height |=| (Dimensions.iPadContext.editorHeightPotrait - 120)
        }
        
        controlPanelContainer.layout(true){
            $0.top == editor.bottomAnchor
            //$0.width |=| (view.frame.width - Dimensions.iPadContext.controlPanelWidth)
            $0.trailing == layerStack.leadingAnchor
            $0.bottom == view.bottomAnchor
            $0.leading == view.leadingAnchor
            
        }
        
        panelController.view.layout{
            $0.top == controlPanelContainer.topAnchor
            $0.trailing == controlPanelContainer.trailingAnchor
            $0.bottom == controlPanelContainer.bottomAnchor
            $0.leading == controlPanelContainer.leadingAnchor
            //$0.width |=| Dimensions.iPadContext.controlPanelWidth
        }
        
        layerStack.layout(true){
            $0.top == editor.bottomAnchor//taskbarContainer.bottomAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
            //$0.leading == controlPanelContainer.trailingAnchor
            $0.width |=| Dimensions.iPadContext.controlPanelWidth
        }
        
    }
    
    
    func iPadLayoutSmallPotrait(){
        //let remHeight = (view.frame.height * 0.40) - 120
        taskbarContainer.layout{
            $0.top == view.topAnchor + 30
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 100
        }
        
        taskbar.view.layout{
            $0.top == taskbarContainer.topAnchor
            $0.bottom == taskbarContainer.bottomAnchor
            $0.trailing == taskbarContainer.trailingAnchor
            $0.leading == taskbarContainer.leadingAnchor
        }
        taskbar.setContentWidth()
        
        editor.layout{
            $0.top == taskbarContainer.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor//controlPanelContainer.leadingAnchor - 2
            //$0.bottom == //layerStack.topAnchor - 2
            $0.height |=| (Dimensions.iPadContext.editorHeightPotrait - 60)
        }
        
        controlPanelContainer.layout(true){
            $0.top == editor.bottomAnchor
            //$0.width |=| (view.frame.width - Dimensions.iPadContext.controlPanelWidth)
            $0.trailing == layerStack.leadingAnchor
            $0.bottom == view.bottomAnchor
            $0.leading == view.leadingAnchor
            
        }
        
        panelController.view.layout{
            $0.top == controlPanelContainer.topAnchor
            $0.trailing == controlPanelContainer.trailingAnchor
            $0.bottom == controlPanelContainer.bottomAnchor
            $0.leading == controlPanelContainer.leadingAnchor
            //$0.width |=| Dimensions.iPadContext.controlPanelWidth
        }
        
        layerStack.layout(true){
            $0.top == editor.bottomAnchor//taskbarContainer.bottomAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
            //$0.leading == controlPanelContainer.trailingAnchor
            $0.width |=| Dimensions.iPadContext.controlPanelWidth
        }
    }
    
    func forceInterfaceForlandscape(){
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
}
