//
//  LineView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class LineView: UIView {

    var startingLocation:CGPoint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        regularInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        regularInit()
    }
    
    func regularInit(){
        backgroundColor = .black
        layer.cornerRadius = 3
    }
    
    class func getLine()->LineView{
        return LineView(frame: .zero)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {return}
//        startingLocation = touch.location(in: self)
//        print("Start location: \(startingLocation!)")
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        guard let start = startingLocation else {return}
//        //        if start.x > 3 || start.x < bounds.maxX - 3 || start.y > 3 || start.y < bounds.maxY - 3{
//        //            return
//        //        }
//        guard let touch = touches.first, let lastTouchLocation = self.startingLocation else {
//            return
//        }
//        let touchLoc = touch.location(in: self)
//        print("New location: \(touchLoc)")
//        let change = touchLoc - lastTouchLocation
//        print("New location: \(change)")
//        
//        
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        startingLocation = 0
//    }
//    
    

    
}



