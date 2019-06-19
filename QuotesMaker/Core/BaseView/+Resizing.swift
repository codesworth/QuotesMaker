//
//  +Resizing.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 18/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension BaseView{
    
    
//    func enterResizeMode(){
//        
//        guard let current = currentSubview else {return}
//        resizingMode = true
//        let frame = current.frame
//        resizerView.frame = frame
//        resizerView.contentView = current
//        addSubview(resizerView)
//        
//    }
//    
//    func exitResizingModeFromGet()->UIView?{
//        guard resizingMode else {return subviews.last}
//        let frame = resizerView.frame
//        let view = resizerView.contentView!
//        addSubview(view)
//        view.frame = frame
//        resizerView.removeFromSuperview()
//        resizingMode = false
//        return view
//    }
    
//    func setupCrossHairsIn(){
//        xCrossHair.isHidden = true
//        yCrossHair.isHidden = true
//        addSubview(xCrossHair)
//        addSubview(yCrossHair)
//    }
    
    @objc func showXCorssHairs(){
        
        //xCrossHair.frame = [rect.midX,rect.origin.y,1,rect.height]
        xCrossHair.frame = [bounds.midX,0,1,bounds.height]
        yCrossHair.frame = [0,bounds.midY,bounds.width,1]
        print("I was added X")
        addSubview(xCrossHair)
    }
    
    @objc func removeAllCrossHairs(){
        removeXCrossHair()
        removeYCrossHair()
    }
    
    @objc func showYCrossHair(){
        print("I was added Y")
        xCrossHair.frame = [bounds.midX,0,1,bounds.height]
        yCrossHair.frame = [0,bounds.midY,bounds.width,1]
        addSubview(yCrossHair)
    }
    
    @objc func removeXCrossHair(){
        print("I was removed X")
        xCrossHair.removeFromSuperview()
    }
    @objc func removeYCrossHair(){
        print("I was removed Y")
        yCrossHair.removeFromSuperview()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        subviews.forEach{
            if let resizer = $0 as? BaseSubView{resizer.focused(false)}}
        //currentSubview = nil
        
    }
    
    
    func constructFrom(model:LayerModel){
        switch model.type {
        case .shape:
            let frame = (model.layerFrame != nil) ? model.layerFrame!.awakeFrom(bounds: bounds) : subBounds
            let shape = RectView(frame: frame)
            addSubviewable(shape)
            shape.model = model as! ShapeModel
            break
        default:
            break
        }
    }
    
}
