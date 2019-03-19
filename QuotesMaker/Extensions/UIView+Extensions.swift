//
//  UIView+Extensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 19/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


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
