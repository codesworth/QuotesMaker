//
//  CGPoint+Literals.swift
//  LiteralExtensions
//
//  Created by Shadrach Mensah on 18/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



extension CGPoint:ExpressibleByArrayLiteral{
    
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: CGFloat...) {
        if elements.count > 1{
            self = CGPoint(x: elements.first!, y: elements.last!)
        }else{
            if elements.isEmpty{
                self = CGPoint.zero
            }else{
                self = CGPoint(x: elements.first!, y: elements.first!)
            }
        }
    }
}


extension CGPoint:ExpressibleByIntegerLiteral{
    
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: IntegerLiteralType) {
        
        self = CGPoint(x: value, y: value)
    }
}


extension CGPoint:ExpressibleByFloatLiteral{
    
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: FloatLiteralType) {
        self = CGPoint(x: value, y: value)
    }
}

