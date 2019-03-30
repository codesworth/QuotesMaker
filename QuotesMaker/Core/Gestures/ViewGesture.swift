//
//  ResizingGesture.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol BaseViewProtocol:class {
    func wakePanelForCurrent()
}


extension UIView{
    
    func setResizableGesture(){
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinched(_:)))
        addGestureRecognizer(gesture)
        
    }
    
    @objc func handlePinched(_ recognizer:UIPinchGestureRecognizer){
        guard let view = recognizer.view else {return}
        view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    func  setPanGesture(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        addGestureRecognizer(pan)
    }
    
    @objc func panned(_ recognizer:UIPanGestureRecognizer){
        guard let view = recognizer.view else {return}
        
        let translation = recognizer.translation(in: view)
        let finalPoint = view.center + translation
        view.center = finalPoint.constrained(in: superview!.bounds)
        recognizer.setTranslation(.zero, in: view)
    }
    
//    @discardableResult
//    func movedInFocus()->UITapGestureRecognizer{
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(wasTapped(_:)))
//        tap.numberOfTapsRequired = 1
//        addGestureRecognizer(tap)
//        return tap
//    }
    
//    @objc func wasTapped(_ gesture:UITapGestureRecognizer){
//        guard let superview = superview as? BaseView, let view = gesture.view else {return}
//        superview.currentSubview = view
//
//    }
//
//    @discardableResult
//    func doubleTappedGesture()->UITapGestureRecognizer{
//        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
//        tap.numberOfTapsRequired = 2
//        addGestureRecognizer(tap)
//        return tap
//    }
//
//    @objc func doubleTapped(_ recognizer:UITapGestureRecognizer){
//        guard let superview = superview as? BaseView, let view = recognizer.view else {return}
//        superview.currentSubview = view
//        superview.delegate?.wakePanelForCurrent()
////        self.layer.borderColor = UIColor.black.cgColor
////        self.layer.borderWidth = 0.5
//    }
    
    func borderlize(_ borderColor:UIColor = .primary,_ width:CGFloat = 1){
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = width
    }
    
    func roundCorners(_ width:CGFloat = 3){
        clipsToBounds = true
        layer.cornerRadius = width
    }
    
//    func addPanDowngesture(){
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedDown(_:)))
//        addGestureRecognizer(panGesture)
//    }
    
    
    
//    @objc func pannedDown(_ recognizer:UIPanGestureRecognizer){
//        guard let view = recognizer.view else {return}
//        
//        //let translation
//    }
}
