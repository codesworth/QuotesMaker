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
        
    }
    
    func stateUndo() {
        if let state = undostates.popLast(){
            switch state.action{
            case .add:
                baseView.currentSubview?.removeFromSuperview()
                let state = State(model: state.model, action: .delete)
                redostates.append(state)
                break
            case .delete:
                undoDelete(state)
                let state = State(model: state.model, action: .add)
                redostates.append(state)
                break
            case .nothing:
                break
            }
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
    
}
