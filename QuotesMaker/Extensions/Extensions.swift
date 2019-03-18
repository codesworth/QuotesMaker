//
//  Extensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension CGRect{
    
    
    
}


extension CGFloat{
    static var fixedWidth:CGFloat{
        return UIScreen.main.bounds.width * 0.9
    }
    
    static var fixedHeight:CGFloat{
        return UIScreen.main.bounds.height * 0.8
    }
    
        
    static func Angle(_ degree:CGFloat)-> CGFloat{
        return (.pi * degree) / 180
    }
}




extension Array{
    
    mutating func push(_ element:Element){
        if count > 10 {
            self = Array(dropFirst())
            append(element)
        }else{
            append(element)
        }
    }
    
    mutating func pop()->Element{
        return popLast()!
    }
    
    var isMulti:Bool{
        return count > 1
    }
}


extension Int{
    
    func nsNumber()->NSNumber{
        return NSNumber(value: self)
    }
}


extension UIView{
    
    func makeLayerFrame()->LayerFrame{
        guard let `super` = superview else {
            fatalError("You Cannot Call UIView.makeLayerFrame() on a view without a superview. Do you know what you are doing?? 🤦‍♂️🤦‍♂️🤦‍♂️")
        }
        
        let initialOrigin = frame.origin
        let origin:CGPoint = [initialOrigin.x / `super`.bounds.maxX,initialOrigin.y / `super`.bounds.maxY]
        let sizedRatio = Dimensions.sizedRatio(of: frame.size, in: `super`.frame.size)
        return LayerFrame(origin, sized: sizedRatio)
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
        }
        if(corners.contains(.layerMaxXMinYCorner)){
            cornerMask.insert(.topRight)
        }
        if(corners.contains(.layerMinXMaxYCorner)){
            cornerMask.insert(.bottomLeft)
        }
        if(corners.contains(.layerMaxXMaxYCorner)){
            cornerMask.insert(.bottomRight)
        }
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        }
    }
    
    
}

extension UIScreen{
    
    enum Handle{
        case xmax_xr
        case xs_x
        case pluses
        case eight_lower
        case fives
        case lowly
    }
    
    func screenType()->Handle{
        let height = UIScreen.main.bounds.height
        
        if height > 890{
            return .xmax_xr
        }
        if height > 800 {
            return .xs_x
        }
        
        if height > 700 {
            return .pluses
        }
        
        if height > 650 {
            return .eight_lower
        }
        
        if height > 550 {
            return .fives
        }
        
        return .lowly
    }
}
