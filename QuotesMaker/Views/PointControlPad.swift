//
//  PointControlPad.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PointControlPad: MaterialView {
    
    
    lazy var pointControl:UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: 20))
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        return view
    }()
    
    var controlPoints:CGPoint?
    
    private var panGesture:UIPanGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit(){
        backgroundColor = .green
        addSubview(pointControl)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        pointControl.center = center
        pointControl.addGestureRecognizer(panGesture!)
        
    }
    
    func setControlTo(_ point:CGPoint){
        
    }
    
    @objc func panned(_ recognizer:UIPanGestureRecognizer){
        guard let view = recognizer.view else {return}
        
        let translation = recognizer.translation(in: view)
        view.center += translation
        recognizer.setTranslation(.zero, in: view)
        
        guard recognizer.state == .ended else{
            return
        }
//        let velocity = recognizer.velocity(in: view)
//        let vectorToFinalPoint = CGPoint(x: velocity.x / 15, y: velocity.y / 15)
//
//        let bounds = self.bounds.inset(by: [5])
//        let finalPoint = view.center + vectorToFinalPoint.clampedWithin(bounds)
//
//        print("The position is: \(pointControl.center)")
//
//        UIView.animate(withDuration: TimeInterval(vectorToFinalPoint.lenght / 1800), delay: 0, options: .curveEaseOut, animations: {
//            view.center = finalPoint
//        }, completion: nil)
        
    }

}
