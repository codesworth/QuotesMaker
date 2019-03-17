//
//  Utils.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class Utils{
    
    
   class func animatePanelsIn(_ view:UIView){
    
        UIView.animate(withDuration: 1) {
            view.frame.origin.y = UIScreen.main.bounds.height - (view.frame.height)
        }
    }
    
    class func animatePanelsOut(_ view:UIView){
        UIView.animate(withDuration: 1,animations: {
            view.frame.origin.y = UIScreen.main.bounds.height + 300
        }, completion:{ _ in view.removeFromSuperview()})
    }
    
    class func fadeIn(_ view:UIView){
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            view.alpha = 1
        }, completion: nil)
    }
    
    class func fadeOut(_ view:UIView, completion:@escaping ()->()){
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {view.alpha = 0}, completion: {_ in completion()})
    }
    
    
    
    class func drawAddInRect()->UIBezierPath{
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 65.85, y: 15.23))
        bezierPath.addCurve(to: CGPoint(x: 66, y: 17.02), controlPoint1: CGPoint(x: 66, y: 15.7), controlPoint2: CGPoint(x: 66, y: 16.14))
        bezierPath.addCurve(to: CGPoint(x: 66, y: 54), controlPoint1: CGPoint(x: 66, y: 17.02), controlPoint2: CGPoint(x: 66, y: 35.28))
        bezierPath.addLine(to: CGPoint(x: 101.94, y: 54))
        bezierPath.addCurve(to: CGPoint(x: 103.7, y: 54.13), controlPoint1: CGPoint(x: 102.86, y: 54), controlPoint2: CGPoint(x: 103.3, y: 54))
        bezierPath.addCurve(to: CGPoint(x: 105, y: 55.9), controlPoint1: CGPoint(x: 104.51, y: 54.42), controlPoint2: CGPoint(x: 105, y: 55.12))
        bezierPath.addCurve(to: CGPoint(x: 105, y: 56.1), controlPoint1: CGPoint(x: 105, y: 56), controlPoint2: CGPoint(x: 105, y: 56.1))
        bezierPath.addCurve(to: CGPoint(x: 103.77, y: 57.85), controlPoint1: CGPoint(x: 105, y: 56.88), controlPoint2: CGPoint(x: 104.51, y: 57.58))
        bezierPath.addCurve(to: CGPoint(x: 101.98, y: 58), controlPoint1: CGPoint(x: 103.3, y: 58), controlPoint2: CGPoint(x: 102.86, y: 58))
        bezierPath.addCurve(to: CGPoint(x: 66, y: 58), controlPoint1: CGPoint(x: 87.44, y: 58), controlPoint2: CGPoint(x: 75.63, y: 58))
        bezierPath.addCurve(to: CGPoint(x: 66, y: 93.94), controlPoint1: CGPoint(x: 66, y: 76.35), controlPoint2: CGPoint(x: 66, y: 93.94))
        bezierPath.addCurve(to: CGPoint(x: 65.87, y: 95.7), controlPoint1: CGPoint(x: 66, y: 94.86), controlPoint2: CGPoint(x: 66, y: 95.3))
        bezierPath.addCurve(to: CGPoint(x: 64.1, y: 97), controlPoint1: CGPoint(x: 65.58, y: 96.51), controlPoint2: CGPoint(x: 64.88, y: 97))
        bezierPath.addLine(to: CGPoint(x: 63.9, y: 97))
        bezierPath.addCurve(to: CGPoint(x: 62.15, y: 95.77), controlPoint1: CGPoint(x: 63.12, y: 97), controlPoint2: CGPoint(x: 62.42, y: 96.51))
        bezierPath.addCurve(to: CGPoint(x: 62, y: 93.98), controlPoint1: CGPoint(x: 62, y: 95.3), controlPoint2: CGPoint(x: 62, y: 94.86))
        bezierPath.addCurve(to: CGPoint(x: 62, y: 58), controlPoint1: CGPoint(x: 62, y: 79.44), controlPoint2: CGPoint(x: 62, y: 67.63))
        bezierPath.addCurve(to: CGPoint(x: 23.3, y: 57.87), controlPoint1: CGPoint(x: 23.95, y: 57.99), controlPoint2: CGPoint(x: 23.61, y: 57.97))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 56.1), controlPoint1: CGPoint(x: 22.49, y: 57.58), controlPoint2: CGPoint(x: 22, y: 56.88))
        bezierPath.addCurve(to: CGPoint(x: 22, y: 55.9), controlPoint1: CGPoint(x: 22, y: 56), controlPoint2: CGPoint(x: 22, y: 55.9))
        bezierPath.addCurve(to: CGPoint(x: 23.23, y: 54.15), controlPoint1: CGPoint(x: 22, y: 55.12), controlPoint2: CGPoint(x: 22.49, y: 54.42))
        bezierPath.addCurve(to: CGPoint(x: 25.02, y: 54), controlPoint1: CGPoint(x: 23.7, y: 54), controlPoint2: CGPoint(x: 24.14, y: 54))
        bezierPath.addLine(to: CGPoint(x: 62, y: 54))
        bezierPath.addCurve(to: CGPoint(x: 62.13, y: 15.3), controlPoint1: CGPoint(x: 62.01, y: 15.95), controlPoint2: CGPoint(x: 62.03, y: 15.61))
        bezierPath.addCurve(to: CGPoint(x: 63.9, y: 14), controlPoint1: CGPoint(x: 62.42, y: 14.49), controlPoint2: CGPoint(x: 63.12, y: 14))
        bezierPath.addLine(to: CGPoint(x: 64.1, y: 14))
        bezierPath.addCurve(to: CGPoint(x: 65.85, y: 15.23), controlPoint1: CGPoint(x: 64.88, y: 14), controlPoint2: CGPoint(x: 65.58, y: 14.49))
        bezierPath.close()
        UIColor.lightGray.setFill()
        bezierPath.fill()
        return bezierPath
    }
    
    class func drawPlusIcon(with color:UIColor)->UIBezierPath{
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 61.41, y: 0.77))
        bezierPath.addCurve(to: CGPoint(x: 61.5, y: 1.89), controlPoint1: CGPoint(x: 61.5, y: 1.06), controlPoint2: CGPoint(x: 61.5, y: 1.34))
        bezierPath.addCurve(to: CGPoint(x: 61.5, y: 58), controlPoint1: CGPoint(x: 61.5, y: 1.89), controlPoint2: CGPoint(x: 61.5, y: 29.72))
        bezierPath.addLine(to: CGPoint(x: 116.94, y: 58))
        bezierPath.addCurve(to: CGPoint(x: 119.02, y: 58.1), controlPoint1: CGPoint(x: 118.4, y: 58), controlPoint2: CGPoint(x: 118.73, y: 58))
        bezierPath.addCurve(to: CGPoint(x: 120, y: 59.43), controlPoint1: CGPoint(x: 119.63, y: 58.31), controlPoint2: CGPoint(x: 120, y: 58.84))
        bezierPath.addCurve(to: CGPoint(x: 119.08, y: 60.89), controlPoint1: CGPoint(x: 120, y: 60.16), controlPoint2: CGPoint(x: 119.63, y: 60.69))
        bezierPath.addCurve(to: CGPoint(x: 117.74, y: 61), controlPoint1: CGPoint(x: 118.73, y: 61), controlPoint2: CGPoint(x: 118.4, y: 61))
        bezierPath.addLine(to: CGPoint(x: 116.94, y: 61))
        bezierPath.addCurve(to: CGPoint(x: 61.5, y: 61), controlPoint1: CGPoint(x: 94.33, y: 61), controlPoint2: CGPoint(x: 76.14, y: 61))
        bezierPath.addCurve(to: CGPoint(x: 61.5, y: 116.94), controlPoint1: CGPoint(x: 61.5, y: 89.23), controlPoint2: CGPoint(x: 61.5, y: 116.94))
        bezierPath.addCurve(to: CGPoint(x: 61.42, y: 119.19), controlPoint1: CGPoint(x: 61.5, y: 118.66), controlPoint2: CGPoint(x: 61.5, y: 118.94))
        bezierPath.addCurve(to: CGPoint(x: 60.31, y: 120), controlPoint1: CGPoint(x: 61.24, y: 119.69), controlPoint2: CGPoint(x: 60.8, y: 120))
        bezierPath.addLine(to: CGPoint(x: 60.19, y: 120))
        bezierPath.addCurve(to: CGPoint(x: 59.09, y: 119.23), controlPoint1: CGPoint(x: 59.7, y: 120), controlPoint2: CGPoint(x: 59.26, y: 119.69))
        bezierPath.addCurve(to: CGPoint(x: 59, y: 118.11), controlPoint1: CGPoint(x: 59, y: 118.94), controlPoint2: CGPoint(x: 59, y: 118.66))
        bezierPath.addLine(to: CGPoint(x: 59, y: 116.94))
        bezierPath.addCurve(to: CGPoint(x: 59, y: 61), controlPoint1: CGPoint(x: 59, y: 94.08), controlPoint2: CGPoint(x: 59, y: 75.73))
        bezierPath.addCurve(to: CGPoint(x: 0.98, y: 60.9), controlPoint1: CGPoint(x: 1.47, y: 61), controlPoint2: CGPoint(x: 1.21, y: 60.98))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 59.58), controlPoint1: CGPoint(x: 0.37, y: 60.69), controlPoint2: CGPoint(x: -0, y: 60.16))
        bezierPath.addCurve(to: CGPoint(x: 0.92, y: 58.11), controlPoint1: CGPoint(x: 0, y: 58.84), controlPoint2: CGPoint(x: 0.37, y: 58.31))
        bezierPath.addCurve(to: CGPoint(x: 2.26, y: 58), controlPoint1: CGPoint(x: 1.27, y: 58), controlPoint2: CGPoint(x: 1.6, y: 58))
        bezierPath.addLine(to: CGPoint(x: 59, y: 58))
        bezierPath.addCurve(to: CGPoint(x: 59.08, y: 0.81), controlPoint1: CGPoint(x: 59, y: 1.22), controlPoint2: CGPoint(x: 59.02, y: 1.01))
        bezierPath.addCurve(to: CGPoint(x: 60.19, y: 0), controlPoint1: CGPoint(x: 59.26, y: 0.31), controlPoint2: CGPoint(x: 59.7, y: 0))
        bezierPath.addLine(to: CGPoint(x: 60.31, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 61.41, y: 0.77), controlPoint1: CGPoint(x: 60.8, y: 0), controlPoint2: CGPoint(x: 61.24, y: 0.31))
        bezierPath.close()
        color.setFill()
        bezierPath.fill()
        
        return bezierPath
    }
}



