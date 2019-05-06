//
//  Coordinator+StateChanges.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension EditingCoordinator:StateChangeable{
    
    func stateRedo() {
        if let state = redostates.popLast(){
            switch state.action{
            case .add:
                undoDelete(state)
                undostates.append(state)
                break
            case .delete:
                removeAddedonUndo()
                break
            case .nothing:
                //changeModel(state: state)
                break
            }
            undostates.append(state)
        }
    }
    
    func stateUndo() {
        if let state = undostates.popLast(){
            switch state.action{
            case .add:
                removeAddedonUndo()
                break
            case .delete:
                undoDelete(state)
                break
            case .nothing:
                changeModel(state: state)
                break
                
            }
            redostates.append(state)
        }
    }
    
    func undoDelete(_ state:State){
        if let model = state.model as? ShapeModel{
            let shape = RectView(frame: model.layerFrame!.awakeFrom(bounds: baseView.bounds))
            baseView.addSubviewable(shape, center: false)
            shape.model = model
        }else if let model = state.model as? ImageLayerModel{
            let image = BackingImageView(frame: model.layerFrame!.awakeFrom(bounds: baseView.bounds))
            baseView.addSubviewable(image, center: false)
            //Load back any visible image: let img = Persistence.
            image.model = model
        }else if let model = state.model as? TextLayerModel{
            let text = BackingTextView(frame: model.layerFrame!.awakeFrom(bounds: baseView.bounds))
            baseView.addSubviewable(text, center: false)
            text.model = model
        }
    }
    
    func removeAddedonUndo(){
        if let current = baseView.currentSubview{
            current.removeFromSuperview()
            baseView.currentSubview = nil
            return
        }
        if let first = baseView.subviews.last{
            first.removeFromSuperview()
        }
    }
    
    @objc func listenForStateChange(_ notification: Notification){
        if let state = notification.userInfo?[.info] as? State{
            undostates.append(state)
        }
    }
    
    func changeModel(state:State){
        if let model = state.model as? ShapeModel{
            if let current = baseView.currentSubview as? RectView{
                DispatchQueue.main.async {
                    current.model = model
                   
                }
                
            }
        }
    }
    
}
