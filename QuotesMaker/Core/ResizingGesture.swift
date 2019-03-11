//
//  ResizingGesture.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol BaseViewProtocol:class {
    
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
    
    func movedInFocus(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasTapped(_:)))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
    }
    
    @objc func wasTapped(_ recognizer:UITapGestureRecognizer){
        if let auto = superview as? BaseView{
            auto.focusDidChange()
        }
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func borderlize(_ borderColor:UIColor = .primary,_ width:CGFloat = 1){
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = width
    }
    
    func roundCorners(_ width:CGFloat = 3){
        clipsToBounds = true
        layer.cornerRadius = width
    }
}
