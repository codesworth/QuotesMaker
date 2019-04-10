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
        default:
            iPadlargeLayoutLandscape()
        }
        iPadlargeLayoutLandscape()
    
    }
    
    func iPadSmallLayoutLandscape(){
        taskbarContainer.layout{
            $0.top == view.topAnchor + 30
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 120
        }
        
        taskbar.view.layout{
            $0.top == taskbarContainer.topAnchor
            $0.bottom == taskbarContainer.bottomAnchor
            $0.trailing == taskbarContainer.trailingAnchor
            $0.leading == taskbarContainer.leadingAnchor
        }
        
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
            $0.height |=| 120
        }
        
        taskbar.view.layout{
            $0.top == taskbarContainer.topAnchor
            $0.bottom == taskbarContainer.bottomAnchor
            $0.trailing == taskbarContainer.trailingAnchor
            $0.leading == taskbarContainer.leadingAnchor
        }
        
        controlPanelContainer.layout{
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
        
    }
    
    func forceInterfaceForlandscape(){
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
}
