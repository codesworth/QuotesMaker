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
        studioPanel.layout{
            $0.top == view.topAnchor + 30
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| studioHeight
        }
        
//        studioPanel.layout{
//            $0.bottom == view.bottomAnchor
//            $0.leading == view.leadingAnchor
//            $0.trailing == view.trailingAnchor
//            $0.height |=| studioHeight
//        }
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
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        if UIDevice.current.userInterfaceIdiom == .phone{
//            return .portrait
//        }else {
//            return .landscape
//        }
//    }
//    
//    override var shouldAutorotate: Bool{
//        if UIDevice.current.userInterfaceIdiom == .phone{
//            return false
//        }else {
//            return true
//        }
//    }
}
