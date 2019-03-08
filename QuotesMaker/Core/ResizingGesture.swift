//
//  ResizingGesture.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit




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
}
