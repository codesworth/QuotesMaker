//
//  PointControlPad.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol PadControlDelegate:class {
    func didUpdateControl(_ point:CGPoint)
}

class PointControlPad: UIView {
    
    
    lazy var pointControl:UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: 20))
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        return view
    }()
    
    weak var delegate:PadControlDelegate?
    
    var controlPoints:CGPoint?{
        didSet{
            delegate?.didUpdateControl(controlPoints!)
        }
    }
    
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
        let finalPoint = view.center + translation
        view.center = finalPoint.constrained(in: bounds)
        
        recognizer.setTranslation(.zero, in: view)
        
        guard recognizer.state == .ended else{
            return
        }
        controlPoints = view.center.maxRatio(in:bounds)
        print("The controlPoint is: \(controlPoints!)")
        
    }
    
    

}
