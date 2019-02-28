//
//  Utils.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class Utils{
    
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
}

