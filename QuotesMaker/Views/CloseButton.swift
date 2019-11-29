//
//  CloseButton.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 11/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class CloseButton: UIButton {
        
        
    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(ovalIn: rect.insetBy(dx: 5, dy: 5))
        UIColor.primaryDark.setFill()
        circle.fill()
        let slash = UIBezierPath()
        let slash2 = UIBezierPath()
        slash2.lineCapStyle = .round
        slash2.lineWidth = 2
        slash.lineWidth = 2
        slash.lineCapStyle = .round
        slash.move(to: CGPoint(x: rect.width * (1/3), y: rect.height * (1/3)))
        slash.addLine(to: CGPoint(x: rect.width * (2 / 3), y: rect.height * (2/3)))
        
        slash2.move(to: CGPoint(x: rect.width * (2 / 3), y: rect.height * (1 / 3)))
        slash2.addLine(to: CGPoint(x: rect.width * (1 / 3), y: rect.height * (2 / 3)))
        UIColor.white.setStroke()
        slash.stroke()
        slash2.stroke()
    }

}
