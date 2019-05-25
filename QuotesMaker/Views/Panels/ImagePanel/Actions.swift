//
//  Actions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 20/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension ImagePanel{
    
    
//    @objc func canUndo(_ notification:Notification){
//        if let canundo = notification.userInfo?[.info] as? Bool{
//            stateControl.undoButt.isEnabled = canundo
//        }
//    }
    
//    @objc func canRedo(_ notification:Notification){
//        if let canundo = notification.userInfo?[.info] as? Bool{
//            stateControl.redoButt.isEnabled = canundo
//        }
//    }
    
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
    
    @objc func cropPressed(_ control:TabControl){
        delegate?.didSelect(.cropMode)
    }
    
    @objc func rotatePressed(_ control:TabControl){
        delegate?.didSelect(.rotate)
    }
    
    @objc func flipHPressed(_ control:TabControl){
        delegate?.didSelect(.flipHorizontal)
    }
    
    @objc func flipVPressed(_ control:TabControl){
        delegate?.didSelect(.flipVertical)
    }
    
    @objc func segChanged(_ control:UISegmentedControl){
        switch control.selectedSegmentIndex {
        case 0:
            delegate?.didSelect(.rotate)
            break
        case 1:
            
            break
        case 2:
            delegate?.didSelect(.flipHorizontal)
            break
        case 3:
            delegate?.didSelect(.flipVertical)
            
            break
        default:
            break
        }
    }
    
    @objc func pickImageFromGallery(){
        delegate?.didSelect(.gallery)
    }
    
    @objc func addFilters(){
        delegate?.didSelect(.filter)
    }
}
